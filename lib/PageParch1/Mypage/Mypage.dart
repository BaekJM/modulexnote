import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../parts/SideManu.dart';
import '../../parts/drawer.dart';
import 'package:fl_chart/fl_chart.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String userEmail = user?.email ?? "Unknown User";
    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600;
    String _Image = "data:image/jpeg;base64,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";


    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: showSideMenu
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 40,
          child: Image.asset('poto/logo3.png'),
        ),
      ),
      drawer: Drawer_otion(),
      body: Row(
        children: [
          if (showSideMenu) SideMenu(parentContext: context),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  _buildProfileSection(
                    name: "김철수",
                    email: userEmail,
                    phone: "010-5678-1234",
                    department: "영업팀",
                    profileUrl: _Image,
                  ),
                  const SizedBox(height: 20),
                  _buildPerformanceAndTasks(),
                  const SizedBox(height: 20),
                  _buildWeeklySchedule(),

                ],
              ),

            ),
          ),
        ],
      ),
    );
  }

  ///1번째 라인
  Widget _buildProfileSection({
    required String name,
    required String email,
    required String phone,
    required String department,
    required String profileUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 왼쪽 2/3: 프로필 카드
        Expanded(
          flex: 2,
          child: _buildProfileCard(
            name: name,
            email: email,
            phone: phone,
            department: department,
            profileUrl: profileUrl,
          ),
        ),

        const SizedBox(width: 20),

        // 오른쪽 1/3: 알림 박스
        Expanded(
          flex: 1,
          child: _buildNotificationCard(),
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    String name = "홍길동",
    String email = "user@example.com",
    String phone = "010-1234-5678",
    String department = "기술개발팀",
    String profileUrl = "https://via.placeholder.com/100", // 임시 사진 URL
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // 프로필 사진
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                profileUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),

            // 정보 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("📧  $email"),
                  Text("📱  $phone"),
                  Text("🏢  $department"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard() {
    final List<NotificationItem> notifications = [
      NotificationItem(
        title: "📩 새로운 메일이 도착하였습니다.",
        detail: "마케팅팀에서 회의 요청 메일이 도착했습니다.",
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationItem(
        title: "📝 새로운 의뢰가 도착하였습니다.",
        detail: "고객사 A에서 4월 견적 요청을 보냈습니다.",
        time: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationItem(
        title: "📅 새로운 일정이 생겼습니다.",
        detail: "4/3(수) 오전 10시, 디자인 미팅이 추가되었습니다.",
        time: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    String _formatTimeAgo(DateTime time) {
      final Duration diff = DateTime.now().difference(time);

      if (diff.inMinutes < 1) return "방금 전";
      if (diff.inMinutes < 60) return "${diff.inMinutes}분 전";
      if (diff.inHours < 24) return "${diff.inHours}시간 전";
      return "${diff.inDays}일 전";
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📢 알림",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            ...notifications.map(
                  (notification) => Stack(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(right: 30), // 오른쪽 공간 확보
                    title: Text(notification.title, style: const TextStyle(fontSize: 14)),
                    subtitle: Text(
                      _formatTimeAgo(notification.time),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(notification.title),
                          content: Text(notification.detail),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("확인"),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'N',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  ///2번째 라인
  Widget _buildPerformanceAndTasks() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 왼쪽 2/3 - 실적 그래프
        Expanded(
          flex: 2,
          child: _buildPerformanceChartCard(),
        ),
        const SizedBox(width: 20),

        // 오른쪽 1/3 - 현재 안건 리스트
        Expanded(
          flex: 1,
          child: _buildCurrentTasksCard(),
        ),
      ],
    );
  }

  Widget _buildPerformanceChartCard() {
    // 실제 안건 수 데이터 (예시)
    final List<double> taskCounts = [
      3, 5, 7, 4, 6, 8, 2, 1, 9, 5, 6, 7, 4 // 13개월 (2025.4 ~ 2026.4)
    ];

    final List<String> months = [
      "4월", "5월", "6월", "7월", "8월", "9월", "10월",
      "11월", "12월", "1월", "2월", "3월"
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📊 개인 실적표 (안건 수 기준)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 240,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10,
                  barTouchData: BarTouchData(enabled: true),
                  barGroups: List.generate(taskCounts.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: taskCounts[index],
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(4),
                        )
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                        interval: 2,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < months.length) {
                            return Transform.rotate(
                              angle: -0.5,
                              child: Text(
                                months[value.toInt()],
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTasksCard() {
    // 각 상태별 안건 리스트 (예시)
    List<String> newTasks = ["요구사항 수집", "신규 제안서 작성"];
    List<String> ongoingTasks = ["기획안 피드백 반영", "개발 중간 점검", "디자인 협의"];
    List<String> completedTasks = ["기획 완료", "고객 미팅 종료", "프로젝트 A 완료"];

    Widget section(String title, List<String> tasks, Color color) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            ...tasks.take(3).map((task) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("- $task"),
            )),
          ],
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🗂️ 현재 안건",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // 섹션별 출력
            section("🆕 신규 안건", newTasks, Colors.blue),
            section("🚧 진행 중", ongoingTasks, Colors.orange),
            section("✅ 종료된 안건", completedTasks, Colors.green),
          ],
        ),
      ),
    );
  }

  int _weekOffset = 0; // 기준 주에서 몇 주 전/후인지
  DateTime? _selectedDate;


  Widget _buildWeeklySchedule() {
    DateTime baseDate = DateTime.now().add(Duration(days: _weekOffset * 7));
    DateTime startDate = baseDate.subtract(Duration(days: baseDate.weekday - 1));
    List<DateTime> twoWeekDates = List.generate(14, (i) => startDate.add(Duration(days: i)));
    DateTime selectedDate = _selectedDate ?? DateTime.now();

    Map<String, List<Schedule>> scheduleMap = {
      "2025-03-31": [
        Schedule(title: "주간 회의", startTime: "10:00", endTime: "11:00", importance: "high", type: "회의"),
        Schedule(title: "보고서 제출", startTime: "13:00", endTime: "13:30", importance: "medium", type: "보고"),
        Schedule(title: "고객 미팅", startTime: "15:00", endTime: "16:30", importance: "high", type: "외근"),
        Schedule(title: "야근 예정", startTime: "19:00", endTime: "21:00", importance: "low", type: "기타"),
      ],
      "2025-04-01": [
        Schedule(title: "개발 일정 점검", startTime: "09:30", endTime: "10:30", importance: "medium", type: "개발"),
        Schedule(title: "피드백 정리", startTime: "11:00", endTime: "11:30", importance: "low", type: "작업"),
        Schedule(title: "디자인 미팅", startTime: "14:00", endTime: "15:00", importance: "high", type: "회의"),
        Schedule(title: "소스코드 리뷰", startTime: "16:00", endTime: "17:00", importance: "medium", type: "개발"),
      ],
      "2025-04-02": [
        Schedule(title: "기획 회의", startTime: "10:00", endTime: "11:30", importance: "high", type: "회의"),
        Schedule(title: "문서 정리", startTime: "13:00", endTime: "14:00", importance: "low", type: "작업"),
        Schedule(title: "기술 교육", startTime: "15:00", endTime: "17:00", importance: "medium", type: "교육"),
      ],
    };
    Icon _iconForType(String type) {
      switch (type) {
        case "회의":
          return const Icon(Icons.meeting_room, size: 18, color: Colors.blue);
        case "개발":
          return const Icon(Icons.code, size: 18, color: Colors.green);
        case "작업":
          return const Icon(Icons.build, size: 18, color: Colors.orange);
        case "교육":
          return const Icon(Icons.school, size: 18, color: Colors.indigo);
        case "외근":
          return const Icon(Icons.directions_walk, size: 18, color: Colors.brown);
        default:
          return const Icon(Icons.event_note, size: 18, color: Colors.grey);
      }
    }
    Color _colorForImportance(String importance) {
      switch (importance) {
        case "high":
          return Colors.redAccent;
        case "medium":
          return Colors.orange;
        case "low":
          return Colors.grey;
        default:
          return Colors.black;
      }
    }



    List<Schedule> currentList = scheduleMap[_dateKey(selectedDate)] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목 + 좌우 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "📅 이번 주 스케줄",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _weekOffset -= 1;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _weekOffset += 1;
                    });
                  },
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),

        // 날짜 선택 바
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: twoWeekDates.length,
            itemBuilder: (context, index) {
              DateTime date = twoWeekDates[index];
              bool isSelected = date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blueAccent : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${date.month}/${date.day}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          )),
                      const SizedBox(height: 4),
                      Text(
                        ["월", "화", "수", "목", "금", "토", "일"][date.weekday - 1],
                        style: TextStyle(color: isSelected ? Colors.white : Colors.black54),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        // 일정 카드
        Container(
          constraints: const BoxConstraints(minHeight: 100, maxHeight: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: currentList.isEmpty
                ? const Text("스케줄 없음", style: TextStyle(color: Colors.grey))
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: currentList.map((item) {
                Color importanceColor;
                switch (item.importance) {
                  case "high":
                    importanceColor = Colors.red;
                    break;
                  case "medium":
                    importanceColor = Colors.orange;
                    break;
                  case "low":
                  default:
                    importanceColor = Colors.grey;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      _iconForType(item.type), // ← 함수 실행!
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${item.startTime} ~ ${item.endTime} [${item.type}] ${item.title}",
                          style: TextStyle(
                            fontSize: 14,
                            color: _colorForImportance(item.importance), // 중요도 색상
                          ),
                        ),
                      ),
                    ],
                  ),
                );

              }).toList(),
            ),
          ),
        ),
      ],
    );
  }


  String _dateKey(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}


class NotificationItem {
  final String title;
  final String detail;
  final DateTime time;

  NotificationItem({required this.title, required this.detail, required this.time});
}

class Schedule {
  final String title;
  final String startTime;
  final String endTime;
  final String importance; // high, medium, low
  final String type; // 회의, 개발 등

  Schedule({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.importance,
    required this.type,
  });
}
