import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'Edit_Ladder.dart';


Widget LadderNewsCard(Function()? onTap, QueryDocumentSnapshot doc) {
  String Title = "title";
  String day = "day";
  String content = "content";
  String Point = "Point";
  String color = "color";


  final intValue = int.tryParse(doc[color]) ?? 0xFF000000;


  return InkWell(
    onTap: onTap,
    child: Container(
      height: 125,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white, // 필요 시 배경색 추가
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글게 처리
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12, // 그림자 색
                          blurRadius: 4, // 흐림 정도
                          offset: Offset(2, 2), // 그림자 위치
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image.asset('poto/logo3.png', fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 220,
                        child: Text(
                          "${doc[Title]}",
                          style: TextStyle(fontSize: 24),
                          maxLines: 1,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Center(
                          child: Container(
                            height: 2,
                            color: Color(intValue),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.room,size: 16,),
                          Text(
                            "${doc[Point]}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.receipt_long,size: 16,),
                          Container(
                            width: 220,
                            child: Text(
                              doc[content],
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 80,
                        child: Text(
                          doc[day],
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    ),
  );
}

///Read
class LadderServePage extends StatefulWidget {
  LadderServePage(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<LadderServePage> createState() => _LadderServePageState();
}

class _LadderServePageState extends State<LadderServePage> {
  final String Title = "title";
  final String day = "day";
  final String content = "content";
  final String Point = "Point";
  final String Name = "Name";
  final String id = "id";

  bool _visibility = true;
  double _PageSize = 360;
  double _PageEndSize = 50;
  Icon _PageIcon = Icon(Icons.arrow_drop_up, size: 35);

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD3F1F1F1),
      appBar: AppBar(
        title: Container(height: 30, child: Image.asset('poto/logo3.png')),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: (){
                print(widget.doc[id]);
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditLadder(documentId: widget.doc[id])));
          },
              icon: Icon(Icons.edit)
          ),
          IconButton(
            onPressed: () async {
              bool confirmDelete = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    elevation: 2.0,
                    backgroundColor: Colors.white,
                    title: Text("削除確認"),
                    content: Text("本当にこのノートを削除しますか"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // true 반환
                        },
                        child: Text("Yes", style: TextStyle(color: Colors.black)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // false 반환
                        },
                        child: Text("No", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );

              if (confirmDelete ?? false) {
                FirebaseFirestore.instance
                    .collection("Ladder")
                    .doc(widget.doc[id])
                    .delete()
                    .then((value) {
                  Navigator.pop(context);
                }).catchError((error) {
                  print('삭제 실패: $error');
                });
              }
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: _PageSize,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF013B5E),
                  Color(0xFF63CAFF),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('【名前】', style: TextStyle(color: Colors.white, fontSize: 13)),
                  Container(width: 200, height: 2, color: Colors.white24),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.doc[Title],
                      style: TextStyle(color: Colors.white, fontSize: 31),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: _visibility,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('【特徴】', style: TextStyle(color: Colors.white, fontSize: 13)),
                        Container(width: 100, height: 1, color: Colors.white24),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.doc[day],
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: _PageEndSize),
                ],
              ),
            ),
          ),
          Padding(
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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                      hintText: 'Find search Note', border: InputBorder.none),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("Ladder")
                  .doc(widget.doc[Title])
                  .collection("Log")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("ページない"));
                }

                final logData = snapshot.data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                final filteredData = logData.where((note) {
                  return (note['id'] ?? '')
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final item = filteredData[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text("現場名 : ${item['title']}" ?? 'No Title',style: TextStyle(fontSize: 20),),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("借りた人 : ${item['borrower']}" ?? 'No Content'),
                              Text("借用日 : ${item['borrowDate']}" ?? 'No borrowDate'),
                              Text("返却日 : ${item['returnDate']}" ?? 'No returnDate'),
                            ],
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
      ),
    );
  }

  void _PageToggle() {
    setState(() {
      _visibility = !_visibility;
      if (_visibility) {
        _PageIcon = Icon(Icons.arrow_drop_up, size: 35);
        _PageSize = 360;
        _PageEndSize = 50;
      } else {
        _PageIcon = Icon(Icons.arrow_drop_down, size: 35);
        _PageSize = 230;
        _PageEndSize = 20;
      }
    });
  }
}
