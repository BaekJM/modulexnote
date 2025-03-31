import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../parts/ListParch.dart';
import '../../parts/SideManu.dart';
import '../../parts/drawer.dart';
import '../ProjectPage/AddProject/AddImageNoticePage.dart';
import '../ProjectPage/DetailPage.dart';


class ListProjectPage extends StatefulWidget {
  const ListProjectPage({super.key});

  @override
  State<ListProjectPage> createState() => _ListProjectPageState();
}

class _ListProjectPageState extends State<ListProjectPage> {
  String searchQuery = "";
  String selectedCategory = "전체";
  String sortOption = '最新順';

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String userEmail = user?.email ?? "Unknown User";
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  _buildCategoryFilter(),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(color: Colors.grey, thickness: 1, height: 20),
                  ),
                  SizedBox(height: 15),
                  _buildSearchBar(),
                  _buildImageList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => _buildSortFilterSheet(),
              );
            },
            icon: Icon(Icons.filter_list),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }

  Widget _buildSortFilterSheet() {
    final options = ['最新順', '古い順', '規模大きい順', '規模小さい順'];
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("並び順の選択", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...options.map((option) {
            return ListTile(
              title: Text(option),
              leading: Icon(
                sortOption == option ? Icons.radio_button_checked : Icons.radio_button_off,
                color: sortOption == option ? Colors.blue : Colors.grey,
              ),
              onTap: () {
                setState(() {
                  sortOption = option;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  String getOrderField() {
    switch (sortOption) {
      case '古い順':
        return 'day';
      case '規模大きい順':
      case '規模小さい順':
        return 'size';
      default:
        return 'day';
    }
  }

  bool getOrderDescending() {
    switch (sortOption) {
      case '最新順':
      case '規模大きい順':
        return true;
      default:
        return false;
    }
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category['value'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              avatar: Icon(
                category['icon'],
                color: isSelected ? Colors.white : Colors.black54,
                size: 18,
              ),
              label: Text(category['label']),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  selectedCategory = category['value'];
                });
              },
              selectedColor: Colors.blue.shade800,
              backgroundColor: Colors.grey.shade200,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildImageList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("FirstPage")
              .orderBy(getOrderField(), descending: getOrderDescending())
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

            final filteredDocs = snapshot.data!.docs.where((doc) {
              final title = doc['title'] ?? '';
              final category = doc['category'] ?? '전체';
              final matchesSearch = title.toString().toLowerCase().contains(searchQuery.toLowerCase());
              final matchesCategory = (selectedCategory == "전체") || (category == selectedCategory);
              return matchesSearch && matchesCategory;
            }).toList();

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredDocs.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisExtent: 230,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                var notice = filteredDocs[index].data() as Map<String, dynamic>;
                final imageList = List<String>.from(notice['imageUrls'] ?? []);
                final firstImageUrl = imageList.isNotEmpty ? imageList.first : '';
                final pdfUrl = notice['pdfUrl'] ?? '';
                final title = notice['title'] ?? '';
                final contentJson = notice['content'] ?? [];
                final document = Document.fromJson(contentJson);
                final plainText = document.toPlainText();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(filteredDocs[index]),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                plainText.isNotEmpty ? plainText : "内容なし",
                                maxLines: 1,
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
                );
              },
            );
          },
        ),
      ],
    );
  }
}
