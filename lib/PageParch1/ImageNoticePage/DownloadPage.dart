import 'package:ModulexNote/PageParch1/ImageNoticePage/parts/NoticeSidemanu.dart';
import 'package:flutter/material.dart';

class Downloadpage extends StatefulWidget {
  final dynamic notice;

  Downloadpage(this.notice);

  @override
  State<Downloadpage> createState() => _DownloadpageState();
}

class _DownloadpageState extends State<Downloadpage> {

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
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSectionTitle(Icons.picture_as_pdf, "PDF Download"),
                    _buildDownloadTrack([
                      "2025年03月25日",
                      "2025年04月25日",
                      "2025年05月25日",
                      "2025年06月25日",
                      "2025年07月25日",
                    ]),

                    SizedBox(height: 32),
                    _buildSectionTitle(Icons.photo, "Photo Download"),
                    _buildDownloadTrack([
                      "2025年03月12日",
                      "2025年04月30日",
                      // "2025年05月07日",
                      // "2025年06月21日",
                      "2025年07月03日",
                    ]),

                    SizedBox(height: 32),
                    _buildSectionTitle(Icons.assignment, "Report Download"),
                    _buildDownloadTrack([
                      "2025年03月19日",
                      "2025年04月08日",
                      "2025年05月27日",
                      "2025年06月14日",
                      // "2025年07月22日",
                    ]),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blueAccent),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDownloadTrack(List<String> dates) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 8.0, right: 8.0),
          child: Container(
            width: dates.length * 150.0,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.4),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              ...dates.map((date) => _buildDownloadCard(date)).toList(),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadCard(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.download,color: Colors.white,),
            label: Text("Download",style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(date, style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Icon(Icons.pin_drop, color: Colors.blueAccent),
          Container(width: 5, height: 60, color: Colors.blueAccent),
        ],
      ),
    );
  }

}