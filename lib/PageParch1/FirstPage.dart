import 'package:ModulexNote/PageParch1/ImageNoticePage/reportPage.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../LadderList/CalendarPage.dart';
import '../parts/SideManu.dart';
import '../parts/movepage.dart';
import 'ImageNoticePage/AddImageNoticePage.dart';
import 'ImageNoticePage/DetailPage.dart';
import 'Manual/Manualpage.dart';
import 'NoticePage/AddNoticePage.dart';
import 'NoticePage/NoticeDetailPage.dart';
import 'PageParch1.dart';
import 'ImageNoticePage/Agenda_Material  .dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../parts/drawer.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String searchQuery = "";
  final List<String> imageUrls = [
    'poto/test/Image1.jpg',
    'poto/test/Image2.jpg',
    'poto/test/Image3.jpg',
    'poto/test/Image4.jpg',
    'poto/test/Image5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String userEmail = user?.email ?? "Unknown User";
    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600; // 600px 이상이면 사이드 메뉴 표시

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showSideMenu ? null : AppBar(backgroundColor: Colors.white, title: Container(height: 40, child: Image.asset('poto/logo3.png'),),),
      drawer: Drawer_otion(),
      body: Row(
        children: [
          if (showSideMenu) SideMenu(parentContext: context), // 사이드 메뉴 (600px 이상일 때만 표시)
          Expanded(
            flex: 3, // 나머지 75% 영역 사용
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  _buildNoticeList(),  // 공지사항 리스트
                  SizedBox(height: 15),
                  _buildslider(),  // 공지사항 리스트
                  SizedBox(height: 15),
                  Padding(padding: const EdgeInsets.all(8.0), child: Divider(color: Colors.grey, thickness: 1, height: 20,),),
                  SizedBox(height: 15),
                  _buildImageList(context),   // 이미지 공지 리스트
                  SizedBox(height: 15),
                  Padding(padding: const EdgeInsets.all(8.0), child: Divider(color: Colors.grey, thickness: 1, height: 20,),),
                  SizedBox(height: 15),
                  _buildSearchBar(),   // 검색창
                  _buildAgendaList(),  // 🔥 이달의 안건 (복구 완료)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  /// 🔍 검색창 위젯
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black12, width: 3),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            decoration: InputDecoration(
              hintText: 'Find search Note',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  /// 📌 🔥 "이달의 안건" 리스트 (복구 완료)
  Widget _buildAgendaList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("FirstPage").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("データを読み込む際にエラーが発生しました"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("表示するページがありません"));
        }


        List<QueryDocumentSnapshot> filteredData = snapshot.data!.docs.where((note) {
          return note["title"]
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        }).toList();

        // 최신 데이터가 위로 오도록 정렬
        filteredData = filteredData.reversed.toList();

        return Column(
          children: filteredData.map((note) {
            return NewsCard(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => report(note)),
              );
            }, note);
          }).toList(),
        );
      },
    );
  }

  /// 📢 공지사항 리스트
  Widget _buildNoticeList() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "📢 今日のお知らせ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNoticePage()),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("お知らせを追加", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff003f62),
                  foregroundColor: Colors.white,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Notice")
                .orderBy("date", descending: true)
                .limit(5)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("お知らせを読み込む際にエラーが発生しました"));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("📌 現在登録されているお知らせはありません"));
              }


              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var notice = snapshot.data!.docs[index];
                  final title = notice["title"];
                  final contentJson = notice["content"];

                  // ✅ Delta → Document → plain text 로 변환
                  final document = Document.fromJson(contentJson);
                  final plainText = document.toPlainText();

                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    tween: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)),
                    builder: (context, Offset offset, child) {
                      return Transform.translate(
                        offset: offset * MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.white,
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              title,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              plainText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoticeDetailPage(
                                    title: title,
                                    contentDelta: contentJson, docId: notice.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }


  /// 슬라이더 이미지
  Widget _buildslider() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 350,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.75,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enableInfiniteScroll: true,
            scrollPhysics: BouncingScrollPhysics(),
          ),
          items: imageUrls.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    // ✅ 이미지 클릭 시 DetailPage 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage({"imageUrl": imagePath}),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5), // 좌우 간격
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5, // 그림자 블러 (적당히 유지)
                          spreadRadius: 2, // 그림자 확산
                          offset: Offset(4, 4), // 그림자 방향
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath,
                        width: MediaQuery.of(context).size.width * 0.8, // 가로 크기 조절
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high, // 🔹 화질 유지
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/default.jpg', fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 🖼 가로 스크롤 이미지 및 PDF 리스트
  Widget _buildImageList(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🎨 デザイン議題",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsWrite()),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("議題を追加", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff003f62),
                  foregroundColor: Colors.white,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("FirstPage")
                .orderBy("day", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("データの読み込み中にエラーが発生しました"));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("登録されたお知らせはありません"));
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var notice = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  final imageList = List<String>.from(notice['imageUrls'] ?? []);
                  final firstImageUrl = imageList.isNotEmpty ? imageList.first : '';
                  final pdfUrl = notice['pdfUrl'] ?? '';
                  final title = notice['title'] ?? '';
                  final content = notice['content'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(snapshot.data!.docs[index]), // ← DetailPage도 FirstPage에 맞춰야 함
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 200,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ✅ 첫 번째 이미지 썸네일
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                child: firstImageUrl.isNotEmpty
                                    ? Image.network(
                                  firstImageUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 120,
                                    color: Colors.grey[200],
                                    child: Center(child: Icon(Icons.broken_image)),
                                  ),
                                )
                                    : Container(
                                  height: 120,
                                  color: Colors.grey[200],
                                  child: Center(child: Icon(Icons.image_not_supported)),
                                ),
                              ),

                              /// ✅ 타이틀 / PDF 아이콘
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title.isNotEmpty ? title : "タイトルなし",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      content.isNotEmpty ? content : "内容なし",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),

                                    SizedBox(height: 6),
                                    if (pdfUrl.isNotEmpty)
                                      Row(
                                        children: [
                                          Icon(Icons.picture_as_pdf, size: 16, color: Colors.red),
                                          SizedBox(width: 4),
                                          Text("PDF添付", style: TextStyle(fontSize: 12, color: Colors.red)),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
