import 'package:ModulexNote/PageParch1/ProjectPage/parts/NoticeSidemanu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

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
    final List<dynamic> contentJson = data["content"] ?? [];
    final Document document = Document.fromJson(contentJson);
    final String content = document.toPlainText();
    final String pdfUrl = data["pdfUrl"] ?? "";
    final String day = data["day"] ?? "";
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
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('FirstPage')
                            .doc(day)
                            .delete();
                        Navigator.pop(context);
                        showSuccessDialog(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: BorderSide(color: Colors.redAccent),
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      ),
                      child: Text(
                        '            Delete Project            ',
                        style: TextStyle(fontSize: 16),
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
}void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // 밖을 눌러도 안 닫힘
    builder: (context) {
      // 3초 후 자동 닫기
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop(); // 다이얼로그 닫기
      });

      return Center(
        child: Container(
          width: 400,
          height: 200,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 48),
              SizedBox(height: 16),
              Text(
                '削除が完了しました',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    },
  );
}
