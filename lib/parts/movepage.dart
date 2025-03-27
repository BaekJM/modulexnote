import 'package:flutter/material.dart';

void move(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: Duration.zero, // ← 애니메이션 제거
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    ),
  );
}


void moveWithSlide(BuildContext context, Widget page) {
  Navigator.pop(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child; // 🚫 애니메이션 없이 즉시 전환
      },
    ),
  );
}
