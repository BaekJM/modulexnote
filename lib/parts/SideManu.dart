import 'package:ModulexNote/PageParch1/ListProject/ListProject.dart';
import 'package:ModulexNote/PageParch1/Mypage/Mypage.dart';
import 'package:flutter/material.dart';

import '../PageParch1/Dashbord.dart';
import '../PageParch1/FirstPage.dart';
import '../PageParch1/LadderList/CalendarPage.dart';
import '../PageParch1/Manual/Manualpage.dart';
import '../PageParch1/StockStatus/StockStatusPage.dart';
import '../stoppage.dart';
import 'movepage.dart';


class SideMenu extends StatefulWidget {
  final BuildContext parentContext;

  const SideMenu({super.key, required this.parentContext});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    double size = isExpanded ? 0.15 : 0.07;

    return Container(
      width: MediaQuery.of(context).size.width * size,
      color: const Color(0x83003f62),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Menu Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isExpanded)
                Row(
                  children: const [
                    Icon(Icons.list, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text("Menu", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                icon: Icon(
                  isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              )
            ],
          ),

          const SizedBox(height: 15),

          _menuButton("Home", Icons.home, () {
            move(widget.parentContext, FirstPage());
          }),
          _menuButton("My Page", Icons.person, () {
            move(widget.parentContext, Mypage());
          }),
          _menuButton("Project", Icons.list_alt, () {
            move(widget.parentContext, ListProjectPage());
          }),
          _menuButton("Rent", Icons.restart_alt_outlined, () {
            move(widget.parentContext, CalendarPage());
          }),
          _menuButton("Dashboard", Icons.auto_graph, () {
            move(widget.parentContext, DashboardChartPage());
          }),
          _menuButton("Inventory", Icons.inventory, () {
            move(widget.parentContext, StockStatusPage());
          }),
          _menuButton("Manual", Icons.book, () {
            move(widget.parentContext, Manualpage());
          }),
        ],
      ),
    );
  }

  Widget _menuButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity, // 좌우로 최대
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white70,
            elevation: 5,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(child: Icon(icon, color: const Color(0xff003f62),size: 30,),flex: 1,),
              if (isExpanded) ...[
                Expanded(
                  child: Text(
                    title, style: const TextStyle(color: Color(0xff003f62), fontSize: 15),
                  ),flex: 2,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarMenu extends StatefulWidget {
  final BuildContext parentContext;

  const AppBarMenu({super.key, required this.parentContext});

  @override
  State<AppBarMenu> createState() => _AppBarMenuState();
}

class _AppBarMenuState extends State<AppBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset("poto/logo3.png"),
          ),
          Row(children: [
            _menuButton("Home", Icons.home, () {
              move(widget.parentContext, FirstPage());
            }),
            _menuButton("My Page", Icons.person, () {
              move(widget.parentContext, Mypage());
            }),
            _menuButton("Project", Icons.list_alt, () {
              move(widget.parentContext, ListProjectPage());
            }),
            _menuButton("Rent", Icons.restart_alt_outlined, () {
              move(widget.parentContext, CalendarPage());
            }),
            _menuButton("Dashboard", Icons.auto_graph, () {
              move(widget.parentContext, DashboardChartPage());
            }),
            _menuButton("Inventory", Icons.inventory, () {
              move(widget.parentContext, StockStatusPage());
            }),
            _menuButton("Manual", Icons.book, () {
              move(widget.parentContext, Manualpage());
            }),
          ],
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Color(0xff003f62)),
        label: Text(title, style: const TextStyle(color: Color(0xff003f62))),
      ),
    );
  }
}



