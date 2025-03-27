import 'package:flutter/material.dart';

import '../LadderList/CalendarPage.dart';
import '../PageParch1/Dashbord.dart';
import '../PageParch1/FirstPage.dart';
import '../PageParch1/Manual/Manualpage.dart';
import 'movepage.dart';


class SideMenu extends StatelessWidget {
  final BuildContext parentContext;

  const SideMenu({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20, // ¼ 크기
      color: const Color(0x83003f62),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.list, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text("Menu", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          _menuButton("Home", Icons.home, () {
            move(parentContext, FirstPage());
          }),
          _menuButton("Rent", Icons.restart_alt_outlined, () {
            move(parentContext, CalendarPage());
          }),
          _menuButton("Dashboard", Icons.auto_graph, () {
            move(parentContext, DashboardChartPage());
          }),
          _menuButton("Manual", Icons.book, () {
            move(parentContext, Manualpage());
          }),
        ],
      ),
    );
  }

  static Widget _menuButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Color(0xff003f62)),
        ),
        label: Center(
          child: Text(title, style: const TextStyle(color: Color(0xff003f62), fontSize: 15)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          elevation: 5,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
