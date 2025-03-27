import 'package:ModulexNote/PageParch1/ImageNoticePage/setting.dart';
import 'package:flutter/material.dart';
import 'package:ModulexNote/PageParch1/ImageNoticePage/reportPage.dart';
import '../../../parts/movepage.dart';
import '../../FirstPage.dart';
import '../DetailPage.dart';
import '../DownloadPage.dart';

class NoticeSideMenu extends StatelessWidget {
  final BuildContext parentContext;
  final dynamic noticeData; // 👉 필요 시 문서 데이터를 넘겨줄 수 있도록 추가

  const NoticeSideMenu({
    super.key,
    required this.parentContext,
    this.noticeData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
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

          /// 🔙 뒤로가기
          _menuButton("戻る", Icons.arrow_back_ios, () {
            Navigator.pop(parentContext);
          }),

          /// 📝 DetailPage 이동
          _menuButton("案件詳細", Icons.info_outline, () {
            if (noticeData != null) {
              move(parentContext, DetailPage(noticeData));
            } else {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text("데이터가 없습니다.")),
              );
            }
          }),

          /// 📄 Report 이동
          _menuButton("レポート", Icons.description, () {
            if (noticeData != null) {
              move(parentContext, report(noticeData));
            } else {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text("レポートデータがありません。")),
              );
            }
          }),

          /// 🚧 다른 메뉴들
          _menuButton("ダウンロード", Icons.download, () {
            if (noticeData != null) {
              move(parentContext, Downloadpage(noticeData));
            } else {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text("レポートデータがありません。")),
              );
            }
          }),

          _menuButton("データ", Icons.settings, () {
            if (noticeData != null) {
              move(parentContext, Settingpage(noticeData));
            } else {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text("レポートデータがありません。")),
              );
            }
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
