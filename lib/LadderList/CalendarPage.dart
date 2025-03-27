import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../PageParch1/FirstPage.dart';
import '../parts/drawer.dart';
import '../parts/SideManu.dart';
import 'Ladder_firestpage.dart';
import 'event/add_event.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  Map<String, Color> colorMap = {}; // 클래스 범위에서 선언
  DateTime? _selectedDay;
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  CalendarFormat _calendarFormat = CalendarFormat.month; // 달력 포맷 기본 값
  Color? fetchedColor; // 가져온 색상을 저장할 변수
  bool isExpanded = false; // 크기 조절을 위한 상태 변수
  User? user = FirebaseAuth.instance.currentUser; // 🔥 현재 로그인한 사용자 가져오기


  String code = "0000000";

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    generateDailyCode();
  }
  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController 해제
    super.dispose();
  }

  Future<void> generateDailyCode() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String today = DateTime.now().toLocal().toString().split(' ')[0]; // YYYY-MM-DD 형식

    DocumentReference docRef = firestore.collection('daily_codes').doc(today);
    DocumentSnapshot doc = await docRef.get();

    if (!doc.exists) {
      // 🔥 Firestore에 오늘 날짜의 코드가 없을 때만 새 코드 생성
      String newCode = (10000000 + Random().nextInt(90000000)).toString(); // 8자리 숫자 생성

      await docRef.set({
        'code': newCode, // ✅ 'code' 필드명으로 Firestore에 저장
      });

      setState(() {
        code = newCode; // ✅ 변수 'code' 업데이트
      });

      print("🔥 오늘의 인증 코드 생성됨: $newCode (Firestore에 저장됨)");
    } else {
      setState(() {
        code = doc['code']; // ✅ Firestore에서 가져온 기존 코드 적용
      });

      print("✅ Firestore에서 기존 인증 코드 유지: ${doc['code']}");
    }
  }


  Future<void> _fetchEvents() async {
    final eventCollection = FirebaseFirestore.instance.collection('event');
    final eventDocs = await eventCollection.get();

    Map<DateTime, List<Map<String, dynamic>>> tempEvents = {};

    for (var eventDoc in eventDocs.docs) {
      final data = eventDoc.data();

      // _selecteItem 값이 null이 아니고, items에 포함되어 있지 않다면 필터링
      if (_selecteItem != null &&
          !(data['items'] as List<dynamic>).contains(_selecteItem)) {
        continue;
      }

      String itemsKey = (data['items'] != null && data['items'].isNotEmpty)
          ? data['items'].join(', ')
          : 'Unknown';

      DateTime borrowDate = DateTime.parse(data['borrowDate']);
      DateTime returnDate = DateTime.parse(data['returnDate']);

      for (DateTime date = borrowDate;
      !date.isAfter(returnDate);
      date = date.add(const Duration(days: 1))) {
        DateTime normalizedDate = DateTime(date.year, date.month, date.day);

        if (!tempEvents.containsKey(normalizedDate)) {
          tempEvents[normalizedDate] = [];
        }

        tempEvents[normalizedDate]!.add({
          'title': data['title'] ?? 'No Title',
          'borrower': data['borrower'] ?? 'Unknown',
          'location': data['location'] ?? 'No Location',
          'items': data['items'] ?? [],
          'color': data['itemColors'] ?? [],
          'id': data['id'] ?? [],
          'borrowDate': borrowDate,
          'returnDate': returnDate,
        });
      }
    }

    setState(() {
      _events = tempEvents;
    });
  }

  final ScrollController _scrollController = ScrollController();

  Widget _buildTimeline() {
    return FutureBuilder<Map<String, List<DocumentSnapshot>>>(
      future: _fetchLadderAndEventDocuments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // 데이터 가져오기
        List<DocumentSnapshot> ladderDocs = snapshot.data?['ladders'] ?? [];

        // Name 데이터 기준으로 정렬
        ladderDocs.sort((a, b) {
          final aName = (a.data() as Map<String, dynamic>?)?['Name'] ?? '0';
          final bName = (b.data() as Map<String, dynamic>?)?['Name'] ?? '0';

          final aNumber = int.tryParse(aName) ?? 0;
          final bNumber = int.tryParse(bName) ?? 0;

          return aNumber.compareTo(bNumber);
        });

        // 타임라인 UI 생성
        return Scrollbar(
          thumbVisibility: true, // 스크롤바 항상 표시
          controller: _scrollController, // ScrollController 연결
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController, // 동일한 ScrollController 사용
            child: Row(
              children: ladderDocs.map((doc) {
                final data = doc.data() as Map<String, dynamic>?;
                final title = data?['title'] ?? 'No Title';
                final description = data?['Point'] ?? 'No Description';
                final colorValue = int.tryParse(data?['color'] ?? '0xFF013B5E') ?? 0xFF013B5E;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selecteItem = title;
                      _fetchEvents();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: isExpanded ? 150 : 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(isExpanded ? 10 : 2),
                        border: Border.all( // 여기 추가
                          color: Color(colorValue),
                          width: isExpanded ? 4 : 1, // 테두리 두께 설정
                        ),                      boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: isExpanded ? 16 : 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // 한 줄까지만 표시
                          ),
                        if (isExpanded) ...[
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }





  Future<Map<String, List<DocumentSnapshot>>> _fetchLadderAndEventDocuments() async {
    final ladderCollection = FirebaseFirestore.instance.collection('Ladder');
    final ladderDocs = await ladderCollection.get();

    final eventCollection = FirebaseFirestore.instance.collection('event');
    final eventDocs = await eventCollection.get();

    return {
      'ladders': ladderDocs.docs,
      'events': eventDocs.docs,
    };
  }

  Map<String, dynamic>? _selectedEvent; // 선택된 이벤트 데이터
  String? _selecteItem; // 선택된 아이탬


  Widget _build24HourTimeline() {
    if (_selectedDay == null) {
      return SizedBox.shrink(); // 선택된 날짜가 없으면 빈 공간 반환
    }

    // 시작 날짜: 선택된 날짜
    final DateTime startDate = _selectedDay!;
    // 종료 날짜: 선택된 날짜로부터 13일 뒤
    final DateTime endDate = startDate.add(Duration(days: 13));

    // 날짜 차이 계산
    final daysCount = endDate.difference(startDate).inDays + 1;

    // 타임라인 데이터를 생성
    List<List<bool>> dailyTimeSlots = List.generate(
      24, // 시간별 슬롯 (0~23시)
          (_) => List.generate(daysCount, (index) => false),
    );

    // 이벤트 데이터 기반으로 시간 범위 계산
    for (int dayOffset = 0; dayOffset < daysCount; dayOffset++) {
      final currentDay = startDate.add(Duration(days: dayOffset));
      final dayEvents = _getEventsForDay(currentDay);

      for (var event in dayEvents) {
        final DateTime borrowDate = event['borrowDate'];
        final DateTime returnDate = event['returnDate'];

        // 현재 날짜에 해당하는 00:00~23:59 사이의 시간 비교를 위해 범위 설정
        final DateTime dayStart = DateTime(currentDay.year, currentDay.month, currentDay.day, 0, 0);
        final DateTime dayEnd = DateTime(currentDay.year, currentDay.month, currentDay.day, 23, 59);

        if (returnDate.isBefore(dayStart) || borrowDate.isAfter(dayEnd)) {
          // 이벤트가 해당 날짜와 겹치지 않음
          continue;
        }

        // 이벤트가 해당 날짜에 속하는 경우
        int startHour = (borrowDate.isAfter(dayStart)) ? borrowDate.hour : 0;
        int endHour = (returnDate.isBefore(dayEnd)) ? returnDate.hour : 23;

        for (int hour = startHour; hour <= endHour; hour++) {
          dailyTimeSlots[hour][dayOffset] = true;
        }
      }
    }

    // 날짜 포맷
    List<String> formattedDates = List.generate(
      daysCount,
          (index) {
        final currentDay = startDate.add(Duration(days: index));
        final weekday = ['日', '月', '火', '水', '木', '金', '土'][currentDay.weekday % 7]; // 일본어 요일
        return "${currentDay.year}年${currentDay.month.toString().padLeft(2, '0')}月${currentDay.day.toString().padLeft(2, '0')}日 ($weekday)";
      },
    );

    // 세로 및 가로 스크롤 가능한 타임라인 생성
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로 스크롤
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // 세로 스크롤
        child: Table(
          defaultColumnWidth: FixedColumnWidth(100.0), // 각 날짜 셀 너비
          border: TableBorder.all(color: Colors.grey), // 테이블 경계선
          children: [
            // 날짜 헤더
            TableRow(
              children: [
                const SizedBox(), // 첫 번째 빈 칸 (시간 표시 열)
                ...List.generate(formattedDates.length, (index) {
                  final currentDay = startDate.add(Duration(days: index));
                  final weekdayColor = currentDay.weekday == DateTime.saturday
                      ? Colors.blue // 토요일은 파란색
                      : currentDay.weekday == DateTime.sunday
                      ? Colors.red // 일요일은 빨간색
                      : Colors.black; // 평일은 검은색

                  final backgroundColor = currentDay.weekday == DateTime.saturday
                      ? Colors.blue.withOpacity(0.2) // 토요일 배경
                      : currentDay.weekday == DateTime.sunday
                      ? Colors.red.withOpacity(0.2) // 일요일 배경
                      : Colors.white; // 평일 배경

                  return Container(
                    color: backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedDates[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: weekdayColor),
                      ),
                    ),
                  );
                }),
              ],
            ),
            // 시간별 타임라인
            ...List.generate(24, (hourIndex) {
              return TableRow(
                children: [
                  // 시간 표시 (세로)
                  Container(
                    height: 30, // 셀 높이와 동일하게 설정
                    alignment: Alignment.center, // 중앙 정렬
                    child: Text(
                      "${hourIndex}:00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 날짜별 시간 슬롯
                  ...List.generate(daysCount, (dayIndex) {
                    final currentDay = startDate.add(Duration(days: dayIndex));
                    final backgroundColor = currentDay.weekday == DateTime.saturday
                        ? Colors.blue.withOpacity(0.2) // 토요일 배경
                        : currentDay.weekday == DateTime.sunday
                        ? Colors.red.withOpacity(0.2) // 일요일 배경
                        : Colors.white; // 평일 배경

                    return Container(
                      height: 30, // 셀 높이
                      color: dailyTimeSlots[hourIndex][dayIndex]
                          ? Color(0xFF013B5E)
                          : backgroundColor,
                    );
                  }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }


  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}年${dateTime.month}月${dateTime.day}日 ${dateTime.hour}時${dateTime.minute}分';
  }
  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final events = _events[DateTime(day.year, day.month, day.day)] ?? [];
    // print("Events for ${DateFormat('yyyy-MM-dd').format(day)}: $events");
    return events;
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600; // 600px 이상이면 사이드 메뉴 표시

    return Scaffold(
      appBar: showSideMenu ? null : AppBar(
        title: Container(
          height: 40,
          child: Image.asset(
            'poto/logo3.png',
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            width: 100,
            height: 30 ,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
              child: Center(child: Text(code,style: TextStyle(color: Colors.black),))
          ),
          SizedBox(width: 12),
          if (user?.email == "modulex@modulex.jp")
            IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LadderFirestpage()),
              );
            },
            icon: Icon(Icons.add_shopping_cart_outlined, color: Colors.white),
          ),
        ],
        backgroundColor: Color(0xFF013B5E),
      ),
      drawer: Drawer_otion(),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (showSideMenu) SideMenu(parentContext: context), // 사이드 메뉴 (600px 이상일 때만 표시)
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1600), // 최대 크기 1200으로 제한
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: [
                      TableCalendar(
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarFormat: _calendarFormat,
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        calendarBuilders: CalendarBuilders(
                          // 요일 색상 지정
                          dowBuilder: (context, day) {
                            final text = DateFormat.E('ja').format(day); // 요일 텍스트 (예: 月, 火, 日)
                            final color = day.weekday == DateTime.sunday
                                ? Colors.red // 일요일은 빨간색
                                : day.weekday == DateTime.saturday
                                ? Colors.blue // 토요일은 파란색
                                : Colors.black; // 평일은 기본 색상
                            return Center(
                              child: Text(
                                text,
                                style: TextStyle(color: color),
                              ),
                            );
                          },
                          // 날짜 텍스트 색상 지정
                          defaultBuilder: (context, day, focusedDay) {
                            final isToday = isSameDay(day, DateTime.now());
                            final color = day.weekday == DateTime.sunday
                                ? Colors.red // 일요일은 빨간색
                                : day.weekday == DateTime.saturday
                                ? Colors.blue // 토요일은 파란색
                                : Colors.black; // 평일은 기본 색상
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isToday ? Colors.yellow.withOpacity(0.3) : null, // 오늘 강조
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${day.day}',
                                style: TextStyle(color: color),
                              ),
                            );
                          },
                          // 데이터 개수만큼 초록색 점 생성
                          markerBuilder: (context, day, events) {
                            final dayEvents = _getEventsForDay(day);
                            if (dayEvents.isNotEmpty) {
                              return Positioned(
                                bottom: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(dayEvents.length, (index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: 1), // 점 간격 조정
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.black12,
                          width: double.infinity,
                          height: 0.5,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF013B5E), // 버튼 색상
                              foregroundColor: Colors.white, // 텍스트 색상
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 패딩
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // 둥근 버튼
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isExpanded ? Icons.photo : Icons.photo_size_select_large,
                                  size: 24,
                                  color: Colors.white, // 아이콘 색상
                                ),
                                SizedBox(width: 8), // 아이콘과 텍스트 간격
                                Text(
                                  isExpanded ? "小さくする(Click)" : "大きくする(Click)",
                                  style: GoogleFonts.notoSansJp(
                                    fontSize: 13  ,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(
                          color: Colors.white,
                          child: _buildTimeline()),
                      SizedBox(height: 10),
                      Text(
                        _selectedDay != null
                            ? "${DateFormat('yyyy-MM-dd').format(_selectedDay!)}の予定"
                            : '${DateFormat('yyyy-MM-dd').format(DateTime.now())}の予定',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(width: double.infinity,height: 1,color: Colors.black12,),
                      ListView.builder(
                        shrinkWrap: true, // 내부 스크롤 허용
                        physics: NeverScrollableScrollPhysics(), // 부모 스크롤과 충돌 방지
                        itemCount: _getEventsForDay(_selectedDay ?? _focusedDay)
                            .where((event) => _selecteItem == null || event['items'].contains(_selecteItem))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredEvents = _getEventsForDay(_selectedDay ?? _focusedDay)
                              .where((event) => _selecteItem == null || event['items'].contains(_selecteItem))
                              .toList();
                          final event = filteredEvents[index];

                          // itemColors 처리: null 체크 및 기본값 설정
                          final Map<String, dynamic> itemColors = event['color'] as Map<String, dynamic>? ?? {};

                          final List<Color> colors = itemColors.entries.map((entry) {
                            // entry.value가 String이면 Color로 변환, 그렇지 않으면 기본값 설정
                            if (entry.value is String) {
                              final colorString = entry.value as String;
                              final intValue = int.tryParse(colorString) ?? 0xFF000000; // 기본값: 검정색
                              return Color(intValue);
                            }
                            return Color(0xFF000000); // 기본값: 검정색
                          }).toList();

                          return Card(
                                color: Colors.white, // 카드 배경 색상
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFF013B5E), // 테두리 색상
                                      width: 3.0, // 테두리 두께
                                    ),
                                    borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기
                                  ),
                                  child: ListTile(
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '現場名 : ${event['location']}',
                                          style: TextStyle(color: Color(0xFF013B5E), fontSize: 20),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '項目 : ${event['items'].join(', ')}',
                                          style: TextStyle(color: Color(0xFF013B5E), fontSize: 18),
                                        ),
                                        // Wrap(
                                        //   children: event['items'].map<Widget>((item) {
                                        //     // 아이템에 해당하는 색상 가져오기
                                        //     final colorString = itemColors[item] as String? ?? '0xFF000000'; // 기본 검정색
                                        //     final int colorValue = int.tryParse(colorString) ?? 0xFF000000;
                                        //
                                        //     return Padding(
                                        //       padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                        //       child: Text(
                                        //         item,
                                        //         style: TextStyle(color: Color(colorValue), fontSize: 18),
                                        //       ),
                                        //     );
                                        //   }).toList(),
                                        // ),
                                        SizedBox(height: 4),
                                        Text(
                                          '借りた人 : ${event['borrower']}',
                                          style: TextStyle(color: Color(0xFF013B5E)),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: colors.map((color) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          '借用日 : ${_formatDate(event['borrowDate'])}',
                                          style: TextStyle(color: Color(0xFF013B5E)),
                                        ),
                                        Text(
                                          '返却日 : ${_formatDate(event['returnDate'])}',
                                          style: TextStyle(color: Color(0xFF013B5E)),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        bool confirmDelete = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              elevation: 2.0,
                                              backgroundColor: Colors.white,
                                              title: Text("削除確認"),
                                              content: Text("本当にこのノートを削除しますか"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(true);
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(false);
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirmDelete ?? false) {
                                          // 1. "event" 컬렉션에서 이벤트 삭제
                                          FirebaseFirestore.instance
                                              .collection("event")
                                              .doc(event['id'])
                                              .delete()
                                              .then((value) {
                                            print('이벤트 삭제 성공: ${event['id']}');
                                          }).catchError((error) {
                                            print('이벤트 삭제 실패: $error');
                                          });

                                          // 2. "Ladder" 컬렉션에서 관련 로그 삭제
                                          List<String> items = List<String>.from(event['items']); // items를 리스트로 변환

                                          await Future.wait(items.map((item) {
                                            return FirebaseFirestore.instance
                                                .collection("Ladder")
                                                .doc(item)
                                                .collection("Log")
                                                .doc(event['id'])
                                                .delete()
                                                .then((value) {
                                              print('Ladder 로그 삭제 성공: $item');
                                            })
                                                .catchError((error) {
                                              print('Ladder 로그 삭제 실패 ($item): $error');
                                            });
                                          }));

                                          // 삭제 작업 완료 후 이벤트 목록 갱신
                                          _fetchEvents();
                                        }

                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),
                                ),
                              );

                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        _selectedDay != null
                            ? "${DateFormat('yyyy-MM-dd').format(_selectedDay!)} から ${DateFormat('yyyy-MM-dd').format(_selectedDay!.add(Duration(days: 14)))} まで"
                            : '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if(_selectedDay != null)
                      Container(width: double.infinity,height: 1,color: Colors.black12,),
                      if (_selecteItem == null || _getEventsForDay(_selectedDay ?? _focusedDay).any((event) => event['items'].contains(_selecteItem)))
                        SizedBox(height: 20),
                      _build24HourTimeline(),
                      SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "お借りする",
            style: GoogleFonts.notoSansJp(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Icon(CupertinoIcons.hand_point_right),
          SizedBox(width: 8,),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEventPage()),
              ).then((_) => _fetchEvents()); // 이벤트 추가 후 새로고침
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
