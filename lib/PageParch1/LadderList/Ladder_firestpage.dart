import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Add_Ladder.dart';
import 'Laader_servePage.dart';

class LadderFirestpage extends StatefulWidget {
  const LadderFirestpage({super.key});

  @override
  _LadderFirestpageState createState() => _LadderFirestpageState();
}

class _LadderFirestpageState extends State<LadderFirestpage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Container(height: 40, child: Image.asset('poto/logo3.png')),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black12, width: 3),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase(); // 검색어 업데이트
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Find search Note',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Ladder").snapshots(),
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
                      .map((note) => LadderNewsCard(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LadderServePage(note)));
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
                  MaterialPageRoute(builder: (context) => NewsLadder()),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
