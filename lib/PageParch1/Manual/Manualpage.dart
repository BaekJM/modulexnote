import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../parts/drawer.dart';
import '../../parts/SideManu.dart';

class Manualpage extends StatefulWidget {
  const Manualpage({super.key});

  @override
  State<Manualpage> createState() => _ManualpageState();
}

class _ManualpageState extends State<Manualpage> {
  double lightAngle = -0.0;
  double lightsize = 200;
  List<Offset> _lights = [Offset(200, -300)];
  int kelvin = 4000;
  double lux = 0.5;

  final List<String> images = [
    'poto/test/test.png',
    'poto/test/test1.png',
    'poto/test/test2.png',
    'poto/test/test3.png',
    'poto/test/test4.png',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToPage(int index) {
    if (index >= 0 && index < images.length) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = index;
      });
    }
  }

  // ✅ Kelvin 값을 RGB 색상으로 변환
  Color kelvinToColor(int kelvin) {
    double temp = kelvin / 100;
    double red, green, blue;

    if (temp <= 66) {
      red = 255;
      green = 99.4708025861 * log(temp) - 161.1195681661;
      blue = temp <= 19 ? 0 : 138.5177312231 * log(temp - 10) - 305.0447927307;
    } else {
      red = 329.698727446 * pow(temp - 60, -0.1332047592);
      green = 288.1221695283 * pow(temp - 60, -0.0755148492);
      blue = 255;
    }

    return Color.fromARGB(
      255,
      red.clamp(0, 255).toInt(),
      green.clamp(0, 255).toInt(),
      blue.clamp(0, 255).toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: showSideMenu
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        title: Container(
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
            child: Stack(
              alignment: Alignment.center,

              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: Image.asset(images[index], fit: BoxFit.contain),
                    );
                  },
                ),

                // 왼쪽 버튼
                if(_currentPage != 0)
                  Positioned(
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white,size: 60,),
                    onPressed: () => _goToPage(_currentPage - 1),
                  ),
                ),

                // 오른쪽 버튼
                if(_currentPage != 4)
                Positioned(
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white,size: 60),
                    onPressed: () => _goToPage(_currentPage + 1),
                  ),
                ),

                ..._lights.asMap().entries.map((entry) {
                  int index = entry.key;
                  Offset position = entry.value;

                  return Positioned(
                    left: position.dx,
                    top: position.dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _lights[index] += details.delta;
                        });
                      },
                      child: Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.diagonal3Values(
                          1.0, // 좌우 확장
                          1.0, // 세로 확장
                          1.0,
                        ),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            // 조명 빛
                            ClipPath(
                              clipper: TriangleLightClipper(), // 또는 DomeLightClipper
                              child: Container(
                                width: lightsize,
                                height: 1000,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      kelvinToColor(kelvin).withOpacity(lux),
                                      kelvinToColor(kelvin).withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // 🔴 드래그 기준점 아래쪽에 빨간 점 표시 (300 아래로)
                            Positioned(
                              top: 485, // ← 여기! 아래로 내림
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  // color: Colors.black45,
                                  shape: BoxShape.circle,
                                  // border: Border.all(color: Colors.white, width: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                // 조명 추가 버튼
                Positioned(
                  left: 20,
                  bottom: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _lights.add(Offset(100, 100));
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text('照明追加', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),

                // 조명 각도 버튼들
                Positioned(
                  left: 20,
                  bottom: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        lightsize = 150;
                      });
                    },
                    child: Text('10°', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        lightsize = 280;
                      });
                    },
                    child: Text('20°', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        lightsize = 400;
                      });
                    },
                    child: Text('35°', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),

                // 켈빈 슬라이더
                Positioned(
                  left: 120,
                  bottom: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("色温: $kelvin K", style: TextStyle(color: Colors.white)),
                      Slider(
                        value: kelvin.toDouble(),
                        min: 2000,
                        max: 7000,
                        divisions: 50,
                        label: "$kelvin K",
                        onChanged: (value) {
                          setState(() {
                            kelvin = value.toInt();
                          });
                        },
                      ),
                      Text("照度: ${(lux * 100).toStringAsFixed(0)} %", style: TextStyle(color: Colors.white)),

                      Slider(
                        value: lux,
                        min: 0,
                        max: 0.6,
                        divisions: 100, // 0.0 ~ 1.0 을 0.1 간격으로
                        label: "${(lux * 100).toStringAsFixed(0)} %",
                        onChanged: (value) {
                          setState(() {
                            lux = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleLightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path()
      ..moveTo(0, h * 1) // 왼쪽 곡선 시작점
      ..quadraticBezierTo(w / 2, 0, w, h * 1) // 위쪽 둥근 곡선
      ..lineTo(w, h) // 오른쪽 아래
      ..lineTo(0, h) // 왼쪽 아래
      ..close(); // 경로 닫기

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}