import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _borrowerController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedBorrowDate;
  TimeOfDay? _selectedBorrowTime;
  DateTime? _selectedReturnDate;
  TimeOfDay? _selectedReturnTime;

  DateTime? _borrow_selectedReturn;
  DateTime? _borrow_selectedBorrowDate;

  double _borrowHour = 0;
  double _borrowMinute = 0;
  double _returnHour = 0;
  double _returnMinute = 0;

  bool Err_message = false; // 등록 버튼 활성화/비활성화 상태 관리


  late Map<String, Map<String, dynamic>> _items = {};
  bool _isSubmitting = false; // 등록 버튼 활성화/비활성화 상태 관리

  final ScrollController _scrollController = ScrollController(); // ScrollController 추가

  @override
  void initState() {
    super.initState();
    _getUserNickname(); // ✅ 로그인한 유저의 닉네임 가져오기
    _fetchRecentLogsFromFirebase(); // Firebase에서 문서 ID 가져오기

    // 현재 날짜와 시간을 가져와서 초기값 설정
    DateTime now = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.now();

    // 반납 시간: 현재 시간 + 2시간 (23시 이상이면 날짜 변경)
    int newReturnHour = currentTime.hour + 2;
    DateTime returnDate = now; // 기본 반납 날짜 = 현재 날짜

    if (newReturnHour >= 24) {
      newReturnHour -= 24; // 24시를 넘기면 0시부터 시작
      returnDate = now.add(Duration(days: 1)); // 다음 날로 변경
    }

    setState(() {
      _selectedBorrowDate = now; // 빌리는 날짜 = 현재 날짜
      _selectedReturnDate = returnDate; // 반납 날짜 (필요시 다음 날)
      _borrowHour = currentTime.hour.toDouble();
      _borrowMinute = currentTime.minute.toDouble();
      _returnHour = newReturnHour.toDouble();
      _returnMinute = _borrowMinute; // 분 단위는 그대로 유지
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController 해제
    _borrowerController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  /// 🔹 현재 로그인한 유저의 닉네임 가져오기
  Future<void> _getUserNickname() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email) // ✅ 이메일 기준으로 유저 데이터 가져오기
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        String? nickname = data['nickname'];

        if (nickname != null) {
          setState(() {
            _borrowerController.text = nickname; // ✅ 빌린 사람 필드에 기본값으로 설정
          });
        }
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> _fetchRecentLogsFromFirebase() async {
    try {
      final eventCollection = FirebaseFirestore.instance.collection('Ladder');
      final eventDocs = await eventCollection.get();

      final Map<String, Map<String, dynamic>> fetchedItems = {};

      // 📌 오늘 날짜 기준 최근 4개월(120일) 전 날짜 계산
      final DateTime fourMonthsAgo = DateTime.now().subtract(Duration(days: 120));

      for (var doc in eventDocs.docs) {
        final data = doc.data();
        if (data.containsKey('title')) {
          String itemName = data['title'];

          // 📌 4개월 이내 borrowDate 데이터만 가져오기
          final logCollection = eventCollection.doc(itemName).collection('Log')
              .where('borrowDate', isGreaterThanOrEqualTo: fourMonthsAgo.toIso8601String())
              .orderBy('borrowDate', descending: true);

          final logDocs = await logCollection.get();

          List<Map<String, dynamic>> logEntries = logDocs.docs.map((log) {
            final logData = log.data();
            return {
              'borrowDate': logData.containsKey('borrowDate') ? DateTime.parse(logData['borrowDate']) : null,
              'returnDate': logData.containsKey('returnDate') ? DateTime.parse(logData['returnDate']) : null,
              'otherData': logData, // 필요한 경우 다른 데이터 포함
            };
          }).toList();

          fetchedItems[itemName] = {
            'isChecked': false,
            'logs': logEntries,
          };
        }
      }

      setState(() {
        _items = fetchedItems;
      });
    } catch (e) {
      print('🔥 Firebase에서 데이터를 가져오는 중 오류 발생: $e');
    }
  }





  Future<void> saveEvent() async {
    if (_borrowerController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedBorrowDate == null ||
        _selectedReturnDate == null ||
        !_items.values.any((item) => item['isChecked'] == true)) { // 체크된 아이템 확인
      showErrorDialog("全ての項目を入力し、物品を選択してください。");
      return;
    }


    setState(() {
      _isSubmitting = true; // 등록 버튼 비활성화
    });

    try {
      // 借用日時と返却日時を生成
      final borrowDateTime = DateTime(
        _selectedBorrowDate!.year,
        _selectedBorrowDate!.month,
        _selectedBorrowDate!.day,
        _borrowHour.toInt(),
        _borrowMinute.toInt(),
      );

      final returnDateTime = DateTime(
        _selectedReturnDate!.year,
        _selectedReturnDate!.month,
        _selectedReturnDate!.day,
        _returnHour.toInt(),
        _returnMinute.toInt(),
      );

      // 체크된 아이템과 색상 정보를 저장
      final List<String> selectedItems = [];
      final Map<String, String> itemColors = {};

      for (var entry in _items.entries.where((entry) => entry.value['isChecked'] == true)) {
        final itemName = entry.key;

        // Ladder 컬렉션에서 해당 문서의 색상 데이터를 가져옴
        final docSnapshot = await FirebaseFirestore.instance
            .collection('Ladder')
            .doc(itemName)
            .get();

        if (docSnapshot.exists && docSnapshot.data() != null) {
          final color = docSnapshot.data()!['color'];
          if (color != null) {
            itemColors[itemName] = color;
          }
        }

        selectedItems.add(itemName);
      }

      // ドキュメントIDを生成 (場所 + 現在の時間)
      String id = "${_locationController.text}_${DateTime.now().millisecondsSinceEpoch}";

      // Firestoreに保存
      await FirebaseFirestore.instance.collection("event").doc(id).set({
        'title': _locationController.text,
        'id': id,
        'borrower': _borrowerController.text,
        'location': _locationController.text,
        'borrowDate': borrowDateTime.toIso8601String(), // 날짜 + 시간 저장
        'returnDate': returnDateTime.toIso8601String(),
        'borrowTime': "${_borrowHour.toInt().toString().padLeft(2, '0')}:${_borrowMinute.toInt().toString().padLeft(2, '0')}",
        'returnTime': "${_returnHour.toInt().toString().padLeft(2, '0')}:${_returnMinute.toInt().toString().padLeft(2, '0')}",
        'items': selectedItems,
        'itemColors': itemColors, // 아이템별 색상 데이터 추가
      });

      // Ladder 로그 저장
      for (var item in selectedItems) {
        await FirebaseFirestore.instance
            .collection("Ladder")
            .doc(item)
            .collection("Log")
            .doc(id)
            .set({
          'title': _locationController.text,
          'id': id,
          'borrower': _borrowerController.text,
          'location': _locationController.text,
          'borrowDate': borrowDateTime.toIso8601String(),
          'returnDate': returnDateTime.toIso8601String(),
          'borrowTime': "${_borrowHour.toInt().toString().padLeft(2, '0')}:${_borrowMinute.toInt().toString().padLeft(2, '0')}",
          'returnTime': "${_returnHour.toInt().toString().padLeft(2, '0')}:${_returnMinute.toInt().toString().padLeft(2, '0')}",
          'item': item, // 개별 아이템 이름
          'timestamp': DateTime.now(), // 로그 저장 시간
        });
      }

      Navigator.pop(context);
    } catch (error) {
      showErrorDialog("イベント保存中にエラーが発生しました。");
    } finally {
      setState(() {
        _isSubmitting = false; // 작업 완료 후 등록 버튼 활성화
      });
    }
  }


  Future<void> selectTime(BuildContext context, bool isBorrowTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isBorrowTime) {
          _selectedBorrowTime = picked;
        } else {
          _selectedReturnTime = picked;
        }
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Text(
            "エラー",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "確認",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          "レンタル追加",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // 텍스트 두껍게 설정
          ),
        ),

      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800), // 너비를 최대 600으로 고정
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text("物品選択", style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                buildLadderSection(),
                SizedBox(height: 40),
                Container(
                  color: Colors.black54,width: double.infinity,height: 0.3,
                ),
                SizedBox(height: 30),
                buildInputSection("借りた人", "借りた人の名前を入力してください。", _borrowerController, enabled: false),
                SizedBox(height: 16),
                buildInputSection("現場名", "場所を入力してください。", _locationController),
                SizedBox(height: 32),
                Text("Time", style: TextStyle(fontSize: 20)),
                Container(
                  color: Colors.black54,width: double.infinity,height: 0.3,
                ),
                SizedBox(height: 16),

                /// 빌리는 날짜 및 시간
                Text("借用日", style: TextStyle(fontSize: 18)),
                buildTableCalendar(true), // 빌리는 날짜 선택용 캘린더
                buildBorrowTimeSlider(),

                SizedBox(height: 24),

                /// 반납 날짜 및 시간
                Text("返却日", style: TextStyle(fontSize: 18)),
                buildTableCalendar(false), // 반납 날짜 선택용 캘린더
                buildReturnTimeSlider(),

                // if (Err_message)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 8.0),
                //     child: Text(
                //       "⚠ 選択した時間は既に予約されています",
                //       style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                //     ),
                //   ),

                SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                        onPressed: _isSubmitting || Err_message || _returnHour == -1 ? null : saveEvent, // 버튼 활성화/비활성화
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: Size(140, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isSubmitting
                            ? CircularProgressIndicator(color: Colors.white)
                            : Center(
                          child: Text(
                            "登録する",
                            style: TextStyle(color: _isSubmitting || Err_message ? Colors.black : Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                /// **📌 중복 예약 에러 메시지 표시**
                if (Err_message)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "⚠ 選択した時間は既に予約されています",
                      style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLadderSection() {
    final sortedItems = _items.keys.toList()
      ..sort((a, b) {
        final regex = RegExp(r'\[(\d+)\]');
        final aMatch = regex.firstMatch(a);
        final bMatch = regex.firstMatch(b);

        final aNumber = aMatch != null ? int.parse(aMatch.group(1)!) : 0;
        final bNumber = bMatch != null ? int.parse(bMatch.group(1)!) : 0;

        return aNumber.compareTo(bNumber);
      });

    return Container(
      width: double.infinity,
      height: 250,
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: ListView(
          controller: _scrollController,
          children: [
            SizedBox(height: 8),
            ...sortedItems.map((item) {
              final itemData = _items[item] ?? {};

              // Firestore에서 가져온 날짜 변환 (문자열 또는 Timestamp 가능)
              DateTime? borrowDate;
              DateTime? returnDate;

              if (itemData['borrowDate'] is String) {
                borrowDate = DateTime.tryParse(itemData['borrowDate']);
              } else if (itemData['borrowDate'] is Timestamp) {
                borrowDate = (itemData['borrowDate'] as Timestamp).toDate();
              }

              if (itemData['returnDate'] is String) {
                returnDate = DateTime.tryParse(itemData['returnDate']);
              } else if (itemData['returnDate'] is Timestamp) {
                returnDate = (itemData['returnDate'] as Timestamp).toDate();
              }

              final now = DateTime.now();

              // 📌 대여 상태 확인 (borrowDate와 returnDate가 모두 있을 때만 true)
              bool isBorrowed = (borrowDate != null && returnDate != null) &&
                  now.isAfter(borrowDate) &&
                  now.isBefore(returnDate);

              return CheckboxListTile(
                title: Text(
                  "$item ${isBorrowed ? '(貸出中)' : ''}",
                  style: TextStyle(
                    fontSize: 18,
                    color: isBorrowed ? Colors.red : Colors.black, // 빌린 경우 빨간색으로 표시
                  ),
                ),
                value: itemData['isChecked'] ?? false, // null 방지
                onChanged: isBorrowed
                    ? null // 📌 이미 빌려진 경우 선택 불가
                    : (bool? value) {
                  setState(() {
                    _items[item]!['isChecked'] = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }



  /// 빌리는 날짜 & 반납 날짜를 선택하는 달력 위젯
  Widget buildTableCalendar(bool isBorrowDate) {
    return TableCalendar(
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2100, 12, 31),
      focusedDay: isBorrowDate
          ? _selectedBorrowDate ?? DateTime.now()
          : _selectedReturnDate ?? DateTime.now(),
      calendarFormat: CalendarFormat.month, // 월 단위 캘린더
      selectedDayPredicate: (day) {
        return isBorrowDate
            ? isSameDay(_selectedBorrowDate, day)
            : isSameDay(_selectedReturnDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          if (isBorrowDate) {
            _selectedBorrowDate = selectedDay;


            _borrowHour = 0;
            _borrowMinute = 0;
            _returnHour = 0;
            _returnMinute = 0;

            // 반납 날짜가 빌리는 날짜보다 과거일 경우 자동 조정
            if (_selectedReturnDate != null && _selectedReturnDate!.isBefore(selectedDay)) {
              _selectedReturnDate = selectedDay;
            }

            // 시간이 반납 시간보다 뒤일 경우 자동 조정 (시간 & 분 비교)
            if (_selectedReturnDate != null && isSameDay(_selectedBorrowDate, _selectedReturnDate)) {
              if (_borrowHour > _returnHour ||
                  (_borrowHour == _returnHour && _borrowMinute > _returnMinute)) {
                _returnHour = _borrowHour;
                _returnMinute = _borrowMinute;
              }
            }
          } else {
            // 반납 날짜가 빌리는 날짜보다 과거일 경우 선택 방지
            if (_selectedBorrowDate != null && selectedDay.isBefore(_selectedBorrowDate!)) {
              showErrorDialog("返却日は借用日より後にしてください。");
              return; // 선택 무효화
            }
            _selectedReturnDate = selectedDay;
          }
        });
      },
      calendarStyle: CalendarStyle(
        weekendTextStyle: TextStyle(
          color: Colors.red, // 일요일 빨간색
        ),
        defaultTextStyle: TextStyle(color: Colors.black), // 기본 텍스트 색상
        todayDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(
          color: Colors.red, // 일요일은 빨간색
        ),
        weekdayStyle: TextStyle(
          color: Colors.black, // 평일은 검정색
        ),
        dowTextFormatter: (date, locale) {
          if (date.weekday == 6) return "土"; // 토요일 (파란색 적용)
          return "${["日", "月", "火", "水", "木", "金", "土"][date.weekday - 1]}";
        },
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false, // 달력 보기 변경 버튼 숨김
        titleCentered: true,
      ),
      availableGestures: AvailableGestures.all,
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.saturday) {
            return Center(
              child: Text(
                "土",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            );
          } else if (day.weekday == DateTime.sunday) {
            return Center(
              child: Text(
                "日",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }
          return null;
        },
        defaultBuilder: (context, day, focusedDay) {
          if (day.weekday == DateTime.saturday) {
            return Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            );
          } else if (day.weekday == DateTime.sunday) {
            return Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }
          return null;
        },
      ),
    );
  }


  /// 📌 빌리는 시간 슬라이더
  /// - 이미 예약된 시간은 빨간색으로 표시
  /// - 선택한 빌리는 시간은 파란색으로 표시
  /// - 날짜가 다르면 반납 시간이 자동 조정됨
  Widget buildBorrowTimeSlider() {
    List<Map<String, dynamic>> borrowedRanges = [];
    DateTime selectedDate = _selectedBorrowDate ?? DateTime.now();

    for (var entry in _items.entries.where((entry) => entry.value['isChecked'] == true)) {
      final logs = entry.value['logs'] as List<Map<String, dynamic>>;

      for (var log in logs) {
        final borrowDate = log['borrowDate'] as DateTime?;
        final returnDate = log['returnDate'] as DateTime?;

        if (borrowDate != null && returnDate != null) {
          DateTime borrowHourOnly = DateTime(borrowDate.year, borrowDate.month, borrowDate.day, borrowDate.hour, 0);
          DateTime returnHourOnly = DateTime(returnDate.year, returnDate.month, returnDate.day, returnDate.hour, 0);

          if ((selectedDate.isAfter(borrowHourOnly) || isSameDay(selectedDate, borrowHourOnly)) &&
              (selectedDate.isBefore(returnHourOnly) || isSameDay(selectedDate, returnHourOnly))) {
            double borrowHour = borrowHourOnly.hour.toDouble();
            double returnHour = returnHourOnly.hour.toDouble();
            borrowedRanges.add({'borrowDate': borrowDate, 'returnDate': returnDate});
          }
        }
      }
    }

    /// 📌 **빌리는 시간과 반납 시간 사이에 기존 예약된 시간이 있는지 검사**
    bool isTimeOverlapping(double newStartHour, double newEndHour, DateTime borrowDate, DateTime returnDate) {
      if (newEndHour == -1) return false; // 반납 시간이 설정되지 않았으면 검사하지 않음

      for (var entry in _items.entries.where((entry) => entry.value['isChecked'] == true)) {
        final logs = entry.value['logs'] as List<Map<String, dynamic>>;

        for (var log in logs) {
          final borrowDateStored = log['borrowDate'] as DateTime?;
          final returnDateStored = log['returnDate'] as DateTime?;

          if (borrowDateStored != null && returnDateStored != null) {
            double storedBorrowHour = borrowDateStored.hour.toDouble();
            double storedReturnHour = returnDateStored.hour.toDouble();

            // 날짜가 같은 경우 기존 로직 유지
            if (isSameDay(borrowDate, returnDate)) {
              if ((newStartHour >= storedBorrowHour && newStartHour < storedReturnHour) ||
                  (newEndHour > storedBorrowHour && newEndHour <= storedReturnHour) ||
                  (newStartHour <= storedBorrowHour && newEndHour >= storedReturnHour)) {
                return true; // 중복된 시간 있음
              }
            }

            // 빌리는 날짜와 반납 날짜가 다를 경우 중간 날짜 검사 (반납 날짜 포함)
            DateTime checkDate = borrowDate.add(Duration(days: 1));

            while (!isSameDay(checkDate, returnDate.add(Duration(days: 1)))) {
              if (isSameDay(checkDate, borrowDateStored) || isSameDay(checkDate, returnDateStored)) {
                return true; // 중간 날짜에 예약된 시간이 있음
              }
              checkDate = checkDate.add(Duration(days: 1)); // 다음 날짜로 이동
            }
          }
        }
      }
      return false; // 겹치지 않음
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "借用時間: ${_borrowHour.toInt().toString().padLeft(2, '0')}:00",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackShape: CustomTrackShape(
              borrowedRanges: borrowedRanges,
              borrowHour: _borrowHour,
              returnHour: _returnHour,
              isBorrow: true,
              selectedBorrowDate: _selectedBorrowDate,
              selectedReturnDate: _selectedReturnDate,
            ),
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.blue,
          ),
          child: Slider(
            value: _borrowHour,
            min: 0,
            max: 23,
            divisions: 23,
            label: "${_borrowHour.toInt()}:00",
              onChanged: (value) {
                setState(() {
                  _borrowHour = value;
                  _borrowMinute = 0;
                  _returnHour = _returnHour == -1 ? _borrowHour + 1 : _returnHour; // 기본값 설정

                  // 날짜가 선택되지 않은 경우 기본 날짜 설정
                  if (_selectedBorrowDate == null) _selectedBorrowDate = DateTime.now();
                  if (_selectedReturnDate == null) _selectedReturnDate = _selectedBorrowDate!.add(Duration(hours: 1));

                  // 반납 시간이 빌리는 시간보다 빠르면 자동 조정
                  if (isSameDay(_selectedBorrowDate!, _selectedReturnDate!) && _returnHour <= _borrowHour) {
                    _returnHour = _borrowHour + 1;
                  }
                  // 빌리는 시간과 기존 예약된 시간이 겹치는지 확인
                  bool isOverlapping = isTimeOverlapping(
                    _borrowHour,
                    _returnHour,
                    _selectedBorrowDate!,
                    _selectedReturnDate!,
                  );

                  Err_message = isOverlapping;
                });
              }

          ),
        ),
        if (Err_message)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "⚠ 選択した時間は既に予約されています",
              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }




  ///반납하는 슬라디으 바
  Widget buildReturnTimeSlider() {
    List<Map<String, dynamic>> borrowedRanges = [];
    DateTime selectedDate = _selectedReturnDate ?? DateTime.now();

    for (var entry in _items.entries.where((entry) => entry.value['isChecked'] == true)) {
      final logs = entry.value['logs'] as List<Map<String, dynamic>>;

      for (var log in logs) {
        final borrowDate = log['borrowDate'] as DateTime?;
        final returnDate = log['returnDate'] as DateTime?;

        if (borrowDate != null && returnDate != null) {
          DateTime borrowHourOnly = DateTime(borrowDate.year, borrowDate.month, borrowDate.day, borrowDate.hour, 0);
          DateTime returnHourOnly = DateTime(returnDate.year, returnDate.month, returnDate.day, returnDate.hour, 0);

          if ((selectedDate.isAfter(borrowHourOnly) || isSameDay(selectedDate, borrowHourOnly)) &&
              (selectedDate.isBefore(returnHourOnly) || isSameDay(selectedDate, returnHourOnly))) {
            double borrowHour = borrowHourOnly.hour.toDouble();
            double returnHour = returnHourOnly.hour.toDouble();
            borrowedRanges.add({'borrowDate': borrowDate, 'returnDate': returnDate});
          }
        }
      }
    }

    bool isTimeOverlapping(double newStartHour, double newEndHour, DateTime borrowDate, DateTime returnDate) {
      if (newEndHour == -1) return false; // 반납 시간이 설정되지 않았으면 검사하지 않음

      for (var entry in _items.entries.where((entry) => entry.value['isChecked'] == true)) {
        final logs = entry.value['logs'] as List<Map<String, dynamic>>;

        for (var log in logs) {
          final borrowDateStored = log['borrowDate'] as DateTime?;
          final returnDateStored = log['returnDate'] as DateTime?;

          if (borrowDateStored != null && returnDateStored != null) {
            double storedBorrowHour = borrowDateStored.hour.toDouble();
            double storedReturnHour = returnDateStored.hour.toDouble();

            // 날짜가 같은 경우 기존 로직 유지
            if (isSameDay(borrowDate, returnDate)) {
              if ((newStartHour >= storedBorrowHour && newStartHour < storedReturnHour) ||
                  (newEndHour > storedBorrowHour && newEndHour <= storedReturnHour) ||
                  (newStartHour <= storedBorrowHour && newEndHour >= storedReturnHour)) {
                return true; // 중복된 시간 있음
              }
            }

            // 빌리는 날짜와 반납 날짜가 다를 경우 중간 날짜 검사 (반납 날짜 포함)
            DateTime checkDate = borrowDate.add(Duration(days: 1));

            while (!isSameDay(checkDate, returnDate.add(Duration(days: 1)))) {
              if (isSameDay(checkDate, borrowDateStored) || isSameDay(checkDate, returnDateStored)) {
                return true; // 중간 날짜에 예약된 시간이 있음
              }
              checkDate = checkDate.add(Duration(days: 1)); // 다음 날짜로 이동
            }
          }
        }
      }
      return false; // 겹치지 않음
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _returnHour == -1 ? "返却時間: 時間の選択をお願いします." : "返却時間: ${_returnHour.toInt().toString().padLeft(2, '0')}:00",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackShape: CustomTrackShape(
              borrowedRanges: borrowedRanges,
              borrowHour: _borrowHour,
              returnHour: _returnHour,
              isBorrow: false,
              selectedBorrowDate: _selectedBorrowDate,
              selectedReturnDate: _selectedReturnDate,
            ),
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.blue,
          ),
          child: Slider(
            value: _returnHour == -1 ? 0 : _returnHour,
            min: 0,
            max: 23,
            divisions: 23,
            label: "${_returnHour.toInt()}:00",
              onChanged: (value) {
                setState(() {
                  _returnHour = value;
                  _returnMinute = 0;

                  // 날짜가 선택되지 않은 경우 기본 날짜 설정
                  if (_selectedBorrowDate == null) _selectedBorrowDate = DateTime.now();
                  if (_selectedReturnDate == null) _selectedReturnDate = _selectedBorrowDate!.add(Duration(hours: 1));

                  // 반납 시간이 빌리는 시간보다 빠르면 자동 조정
                  if (_returnHour <= _borrowHour && isSameDay(_selectedBorrowDate!, _selectedReturnDate!)) {
                    _returnHour = _borrowHour + 1;
                  }

                  // 반납 시간과 기존 예약된 시간이 겹치는지 확인
                  bool isOverlapping = isTimeOverlapping(
                    _borrowHour,
                    _returnHour,
                    _selectedBorrowDate!,
                    _selectedReturnDate!,
                  );

                  Err_message = isOverlapping;
                });
              }

          ),
        ),
      ],
    );
  }



  Widget buildInputSection(String title, String hint, TextEditingController controller, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 700),
          child: TextField(
            controller: controller,
            enabled: enabled, // ✅ "빌린 사람" 필드는 입력 비활성화
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
/// 📌 **커스텀 트랙 페인터** (예약된 시간 빨간색, 선택한 시간 파란색)
class CustomTrackShape extends RoundedRectSliderTrackShape {
  final List<Map<String, dynamic>> borrowedRanges; // 예약된 시간 범위
  final double borrowHour; // 빌리는 시간
  final double returnHour; // 반납 시간
  final bool isBorrow; // 빌리는 시간 슬라이더인지 여부
  final DateTime? selectedBorrowDate; // 선택한 빌리는 날짜
  final DateTime? selectedReturnDate; // 선택한 반납 날짜

  CustomTrackShape({
    required this.borrowedRanges,
    required this.borrowHour,
    required this.returnHour,
    required this.isBorrow,
    required this.selectedBorrowDate,
    required this.selectedReturnDate,
  });

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        Offset? secondaryOffset,
        required Offset thumbCenter,
        bool isDiscrete = false,
        bool isEnabled = true,
        double additionalActiveTrackHeight = 0,
      }) {
    final Paint trackPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;

    final double trackHeight = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    ).height;

    final double trackLeft = offset.dx;
    final double trackWidth = parentBox.size.width;
    final double trackRight = trackLeft + trackWidth;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackBottom = trackTop + trackHeight;

    // 📌 기본 트랙 (회색)
    Rect baseTrack = Rect.fromLTRB(trackLeft, trackTop, trackRight, trackBottom);
    context.canvas.drawRect(baseTrack, trackPaint);

    // 📌 예약된 시간 (빨간색으로 표시)
    final Paint borrowedPaint = Paint()
      ..color = Colors.red.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    for (var range in borrowedRanges) {
      DateTime? borrowDate = range['borrowDate'];
      DateTime? returnDate = range['returnDate'];

      if (borrowDate != null && returnDate != null) {
        DateTime? selectedDate = isBorrow ? selectedBorrowDate : selectedReturnDate;

        if (selectedDate != null) {
          double startX = trackLeft;
          double endX = trackRight;

          if (isSameDay(borrowDate, selectedDate)) {
            // 📌 **빌린 날짜 (borrowDate) → 빌린 시간부터 24시까지 빨간색**
            startX = trackLeft + (trackWidth * (borrowDate.hour / 24));
            endX = trackRight;
          } else if (isSameDay(returnDate, selectedDate)) {
            // 📌 **반납 날짜 (returnDate) → 0시부터 반납 시간까지 빨간색**
            startX = trackLeft;
            endX = trackLeft + (trackWidth * (returnDate.hour / 24));
          } else if (selectedDate.isAfter(borrowDate) && selectedDate.isBefore(returnDate)) {
            // 📌 **빌린 날짜와 반납 날짜 사이에 있는 중간 날짜 → 0시~24시 전부 빨간색**
            startX = trackLeft;
            endX = trackRight;
          }

          Rect borrowedTrack = Rect.fromLTRB(startX, trackTop, endX, trackBottom);
          context.canvas.drawRect(borrowedTrack, borrowedPaint);
        }
      }
    }

    // 📌 사용자가 선택한 시간 (파란색)
    final Paint selectedRangePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    double borrowX;
    double returnX;

    if (selectedBorrowDate != null && selectedReturnDate != null) {
      if (isSameDay(selectedBorrowDate!, selectedReturnDate!)) {
        borrowX = trackLeft + (trackWidth * (borrowHour / 24));
        returnX = trackLeft + (trackWidth * (returnHour / 24));
      } else {
        if (isBorrow) {
          borrowX = trackLeft + (trackWidth * (borrowHour / 24));
          returnX = trackRight;
        } else {
          borrowX = trackLeft;
          returnX = trackLeft + (trackWidth * (returnHour / 24));
        }
      }
    } else {
      borrowX = trackLeft + (trackWidth * (borrowHour / 24));
      returnX = trackLeft + (trackWidth * (returnHour / 24));
    }

    Rect selectedTrack = Rect.fromLTRB(borrowX, trackTop, returnX, trackBottom);
    context.canvas.drawRect(selectedTrack, selectedRangePaint);
  }
}

