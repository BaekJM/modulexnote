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
  Offset _circlePosition = Offset(100, 100); // 초기 위치
  double lightAngle = -0.0; // 0: 정면, 1: 완전히 기울임

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
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
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Image.asset("poto/test/test.png"),
                    ),
                  ),
                ),
                Positioned(
                  left: _circlePosition.dx,
                  top: _circlePosition.dy,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _circlePosition += details.delta;
                      });
                    },
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.diagonal3Values(
                        1.0,
                        2.5 - lightAngle, // 세로 비율을 더 키워 아래로 퍼지게
                        1.0,
                      ),
                      child: Container(
                        width: 400,     // 가로는 그대로
                        height: 300,    // 세로를 더 크게
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Color(0xffffeede).withOpacity(0.4),
                              Color(0xffffeede).withOpacity(0.0),
                            ],
                            stops: [0.0, 0.2], // 퍼짐 정도
                            radius: 2.0,
                            center: Alignment(0.0, -0.6), // 중앙보다 위에서 시작해서 아래로 퍼지게
                          ),
                        ),
                      ),
                    ),

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
