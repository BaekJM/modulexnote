import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'PageParch1/PageParch1.dart';
import 'ServePage.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String userEmail = user!.email!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(height: 40, child: Image.asset('poto/logo3.png')),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                  border: Border.all(color: Colors.black12, width: 3)),
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10), // 최대 10자로 제한
                  ],
                  decoration: InputDecoration(
                      hintText: 'Find search Note', border: InputBorder.none),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("FirstPage").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> filteredData =
                      snapshot.data!.docs.where((note) {
                    // 여기서는 예시로 제목에 검색어가 포함되어 있는지 확인합니다.
                    // 원하는 검색 기준에 따라 수정할 수 있습니다.
                    return note["title"]
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();

                  // 역순으로 된 리스트로 변경
                  filteredData = filteredData.reversed.toList();

                  return Column(
                    children: filteredData
                        .map((note) => NewsCard(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServePage(note)));
                            }, note))
                        .toList(),
                  );
                } else {
                  return Text("페이지 없음");
                }
              },
            ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsWrite()),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              // elevation: 5.0,
            ),
          ),
        ],
      ),
    );
  }
}
