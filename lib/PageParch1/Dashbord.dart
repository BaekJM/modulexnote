import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../parts/SideManu.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

final Map<String, List<Map<String, dynamic>>> graphData = {
  "佐藤": [
    {"month": "2025-04", "cases": 4, "lights": 367},
    {"month": "2025-05", "cases": 3, "lights": 478},
    {"month": "2025-06", "cases": 2, "lights": 280},
    {"month": "2025-07", "cases": 3, "lights": 365},
    {"month": "2025-08", "cases": 2, "lights": 241},
    {"month": "2025-09", "cases": 2, "lights": 256},
    {"month": "2025-10", "cases": 2, "lights": 81},
    {"month": "2025-11", "cases": 2, "lights": 243},
    {"month": "2025-12", "cases": 2, "lights": 285},
    {"month": "2026-01", "cases": 2, "lights": 240},
    {"month": "2026-02", "cases": 2, "lights": 321},
    {"month": "2026-03", "cases": 3, "lights": 278},
    {"month": "2026-04", "cases": 2, "lights": 294},
  ],
  "鈴木": [
    {"month": "2025-04", "cases": 3, "lights": 240},
    {"month": "2025-05", "cases": 2, "lights": 315},
    {"month": "2025-06", "cases": 3, "lights": 152},
    {"month": "2025-07", "cases": 2, "lights": 209},
    {"month": "2025-08", "cases": 2, "lights": 175},
    {"month": "2025-09", "cases": 3, "lights": 194},
    {"month": "2025-10", "cases": 4, "lights": 278},
    {"month": "2025-11", "cases": 3, "lights": 342},
    {"month": "2025-12", "cases": 2, "lights": 160},
    {"month": "2026-01", "cases": 3, "lights": 122},
    {"month": "2026-02", "cases": 3, "lights": 314},
    {"month": "2026-03", "cases": 3, "lights": 245},
    {"month": "2026-04", "cases": 3, "lights": 203},
  ],
  "高橋": [
    {"month": "2025-04", "cases": 2, "lights": 101},
    {"month": "2025-05", "cases": 4, "lights": 189},
    {"month": "2025-06", "cases": 3, "lights": 270},
    {"month": "2025-07", "cases": 2, "lights": 368},
    {"month": "2025-08", "cases": 2, "lights": 170},
    {"month": "2025-09", "cases": 3, "lights": 266},
    {"month": "2025-10", "cases": 3, "lights": 300},
    {"month": "2025-11", "cases": 2, "lights": 231},
    {"month": "2025-12", "cases": 2, "lights": 199},
    {"month": "2026-01", "cases": 3, "lights": 207},
    {"month": "2026-02", "cases": 3, "lights": 390},
    {"month": "2026-03", "cases": 2, "lights": 244},
    {"month": "2026-04", "cases": 3, "lights": 268},
  ],
  "田中": [
    {"month": "2025-04", "cases": 3, "lights": 221},
    {"month": "2025-05", "cases": 2, "lights": 187},
    {"month": "2025-06", "cases": 3, "lights": 264},
    {"month": "2025-07", "cases": 3, "lights": 321},
    {"month": "2025-08", "cases": 2, "lights": 160},
    {"month": "2025-09", "cases": 3, "lights": 199},
    {"month": "2025-10", "cases": 3, "lights": 344},
    {"month": "2025-11", "cases": 2, "lights": 248},
    {"month": "2025-12", "cases": 2, "lights": 174},
    {"month": "2026-01", "cases": 3, "lights": 282},
    {"month": "2026-02", "cases": 2, "lights": 195},
    {"month": "2026-03", "cases": 3, "lights": 301},
    {"month": "2026-04", "cases": 3, "lights": 234},
  ],
  "伊藤": [
    {"month": "2025-04", "cases": 2, "lights": 189},
    {"month": "2025-05", "cases": 3, "lights": 170},
    {"month": "2025-06", "cases": 3, "lights": 212},
    {"month": "2025-07", "cases": 3, "lights": 311},
    {"month": "2025-08", "cases": 2, "lights": 192},
    {"month": "2025-09", "cases": 2, "lights": 147},
    {"month": "2025-10", "cases": 3, "lights": 298},
    {"month": "2025-11", "cases": 2, "lights": 275},
    {"month": "2025-12", "cases": 2, "lights": 261},
    {"month": "2026-01", "cases": 2, "lights": 150},
    {"month": "2026-02", "cases": 3, "lights": 302},
    {"month": "2026-03", "cases": 2, "lights": 264},
    {"month": "2026-04", "cases": 2, "lights": 213},
  ],
  "山本": [
    {"month": "2025-04", "cases": 3, "lights": 256},
    {"month": "2025-05", "cases": 2, "lights": 167},
    {"month": "2025-06", "cases": 3, "lights": 193},
    {"month": "2025-07", "cases": 3, "lights": 320},
    {"month": "2025-08", "cases": 2, "lights": 201},
    {"month": "2025-09", "cases": 2, "lights": 150},
    {"month": "2025-10", "cases": 3, "lights": 273},
    {"month": "2025-11", "cases": 3, "lights": 330},
    {"month": "2025-12", "cases": 2, "lights": 186},
    {"month": "2026-01", "cases": 2, "lights": 229},
    {"month": "2026-02", "cases": 3, "lights": 244},
    {"month": "2026-03", "cases": 3, "lights": 288},
    {"month": "2026-04", "cases": 2, "lights": 214},
  ],
  "中村": [
    {"month": "2025-04", "cases": 3, "lights": 177},
    {"month": "2025-05", "cases": 2, "lights": 260},
    {"month": "2025-06", "cases": 3, "lights": 183},
    {"month": "2025-07", "cases": 2, "lights": 275},
    {"month": "2025-08", "cases": 3, "lights": 220},
    {"month": "2025-09", "cases": 2, "lights": 135},
    {"month": "2025-10", "cases": 3, "lights": 268},
    {"month": "2025-11", "cases": 2, "lights": 298},
    {"month": "2025-12", "cases": 3, "lights": 156},
    {"month": "2026-01", "cases": 3, "lights": 229},
    {"month": "2026-02", "cases": 2, "lights": 262},
    {"month": "2026-03", "cases": 2, "lights": 307},
    {"month": "2026-04", "cases": 3, "lights": 198},
  ],
  "小林": [
    {"month": "2025-04", "cases": 3, "lights": 193},
    {"month": "2025-05", "cases": 2, "lights": 213},
    {"month": "2025-06", "cases": 2, "lights": 204},
    {"month": "2025-07", "cases": 3, "lights": 233},
    {"month": "2025-08", "cases": 3, "lights": 197},
    {"month": "2025-09", "cases": 2, "lights": 265},
    {"month": "2025-10", "cases": 3, "lights": 268},
    {"month": "2025-11", "cases": 2, "lights": 287},
    {"month": "2025-12", "cases": 3, "lights": 174},
    {"month": "2026-01", "cases": 2, "lights": 222},
    {"month": "2026-02", "cases": 2, "lights": 300},
    {"month": "2026-03", "cases": 2, "lights": 278},
    {"month": "2026-04", "cases": 3, "lights": 180},
  ],
  "加藤": [
    {"month": "2025-04", "cases": 2, "lights": 171},
    {"month": "2025-05", "cases": 3, "lights": 188},
    {"month": "2025-06", "cases": 3, "lights": 278},
    {"month": "2025-07", "cases": 3, "lights": 292},
    {"month": "2025-08", "cases": 2, "lights": 215},
    {"month": "2025-09", "cases": 3, "lights": 274},
    {"month": "2025-10", "cases": 2, "lights": 166},
    {"month": "2025-11", "cases": 2, "lights": 199},
    {"month": "2025-12", "cases": 3, "lights": 240},
    {"month": "2026-01", "cases": 3, "lights": 280},
    {"month": "2026-02", "cases": 2, "lights": 222},
    {"month": "2026-03", "cases": 3, "lights": 318},
    {"month": "2026-04", "cases": 2, "lights": 268},
  ],
  "吉田": [
    {"month": "2025-04", "cases": 3, "lights": 213},
    {"month": "2025-05", "cases": 2, "lights": 231},
    {"month": "2025-06", "cases": 3, "lights": 182},
    {"month": "2025-07", "cases": 2, "lights": 248},
    {"month": "2025-08", "cases": 3, "lights": 215},
    {"month": "2025-09", "cases": 2, "lights": 190},
    {"month": "2025-10", "cases": 3, "lights": 265},
    {"month": "2025-11", "cases": 3, "lights": 241},
    {"month": "2025-12", "cases": 3, "lights": 194},
    {"month": "2026-01", "cases": 2, "lights": 252},
    {"month": "2026-02", "cases": 2, "lights": 284},
    {"month": "2026-03", "cases": 3, "lights": 273},
    {"month": "2026-04", "cases": 3, "lights": 219},
  ]
};


class DashboardChartPage extends StatefulWidget {
  const DashboardChartPage({super.key});

  @override
  State<DashboardChartPage> createState() => _DashboardChartPageState();
}

class _DashboardChartPageState extends State<DashboardChartPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600; // 600px 이상이면 사이드 메뉴 표시

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showSideMenu ? null : AppBar(backgroundColor: Colors.white, title: Container(height: 40, child: Image.asset('poto/logo3.png'),),),
      body: Row(
        children: [
          if (showSideMenu) SideMenu(parentContext: context), // 사이드 메뉴 (600px 이상일 때만 표시)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: graphData.entries.map((entry) {
                  final name = entry.key;
                  final data = entry.value;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color(0xff003f62),  // 테두리 색상
                          width: 4,           // 테두리 두께
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle, // 원형
                                    border: Border.all(
                                      color: Color(0xff003f62),  // 테두리 색상
                                      width: 1,           // 테두리 두께
                                    ),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown, // 아이콘을 컨테이너에 맞게 축소
                                    child: Icon(
                                      Icons.person,       // 원하는 아이콘
                                      size: 60,           // 여유 있게 줘도 FittedBox가 조절
                                      color: Colors.blue, // 원하는 색상
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: SizedBox(
                                height: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: LineChart(
                                    LineChartData(
                                      maxY: 700, // 최대 Y값 고정
                                      minY: 0,   // (선택) 최소 Y값도 고정하면 좋음
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(showTitles: false),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 40,
                                            getTitlesWidget: (value, meta) {
                                              if (value % 100 == 0 && value <= 700) {
                                                return Text(value.toInt().toString());
                                              }
                                              return SizedBox.shrink(); // 그 외는 안 보이게
                                            },
                                            interval: 100, // 간격은 100단위로
                                          ),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              final index = value.toInt();
                                              if (index < data.length) {
                                                final month = data[index]['month'].substring(5);
                                                return Text('$month月');
                                              }
                                              return Text('');
                                            },
                                          ),
                                        ),
                                      ),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: [
                                            for (int i = 0; i < data.length; i++)
                                              FlSpot(i.toDouble(), data[i]['cases'].toDouble())
                                          ],
                                          isCurved: true,
                                          color: Colors.blue,
                                          barWidth: 3,
                                        ),
                                        LineChartBarData(
                                          spots: [
                                            for (int i = 0; i < data.length; i++)
                                              FlSpot(i.toDouble(), data[i]['lights'].toDouble())
                                          ],
                                          isCurved: true,
                                          color: Colors.orange,
                                          barWidth: 3,
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
