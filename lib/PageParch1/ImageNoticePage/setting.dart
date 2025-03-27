import 'package:ModulexNote/PageParch1/ImageNoticePage/parts/NoticeSidemanu.dart';
import 'package:flutter/material.dart';

class Settingpage extends StatefulWidget {
  final dynamic notice;

  Settingpage(this.notice);

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
    widget.notice is Map<String, dynamic>
        ? widget.notice
        : (widget.notice.data() as Map<String, dynamic>);

    final String title = data["title"] ?? "";
    final String content = data["content"] ?? "";
    final String pdfUrl = data["pdfUrl"] ?? "";
    final List<String> imageUrls =
    data.containsKey("imageUrls") ? List<String>.from(data["imageUrls"]) : [];


    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    bool showSideMenu = screenWidth > 600;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showSideMenu
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        title: Container(height: 40, child: Image.asset('poto/logo3.png')),
      ),
      body: Row(
        children: [
          if (showSideMenu)
            NoticeSideMenu(
              parentContext: context,
              noticeData: widget.notice,
            ),
          Expanded(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                //
                // /// 제목
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     title,
                //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // SizedBox(height: 12),
                //
                // /// 본문 설명
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     content,
                //     style: TextStyle(fontSize: 16),
                //   ),
                // ),
                // SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}