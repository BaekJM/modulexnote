import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Widget NewsCard(Function()? onTap, QueryDocumentSnapshot doc) {
  String Title = "title";
  String day = "day";
  String content = "content";
  String Point = "Point";
  String Name = "Name";
  String Oner = "Oner";



  return InkWell(
    onTap: onTap,
    child: Container(
      height: 100,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    child: Text(
                      doc[Title],
                      style: TextStyle(fontSize: 24),
                      maxLines: 1,
                    ),
                  ),
                  Container(width: 200,height: 2,color: Color(0xFF013B5E)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.room,size: 16,),
                      Text(
                        doc[Point],
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
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doc[Name],
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 80,
                  child: Text(
                    doc[day],
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

///Write

class NewsWrite extends StatefulWidget {
  const NewsWrite({Key? key}) : super(key: key);

  @override
  State<NewsWrite> createState() => _NewsWriteState();
}

class _NewsWriteState extends State<NewsWrite> {
  String date = DateTime.now().toString();

  ///아마 시간대 불러오는 코드인듯
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  TextEditingController _PointController = TextEditingController();
  TextEditingController _NameController = TextEditingController();
  TextEditingController _OnerController = TextEditingController();

  String Title = "title";
  String day = "day";
  String content = "content";
  String Point = "Point";
  String Name = "Name";
  String Oner = "Oner";

  String isChecked = "isChecked";
  String isArm = "isArm";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Add New Project",
          style: TextStyle(
            fontFamily: 'CustomFont', // 위에서 정의한 폰트 패밀리 이름 사용
            fontSize: 25.0, // 원하는 폰트 크기 설정
            fontWeight: FontWeight.bold, // 원하는 폰트 굵기 설정
            // 추가적인 스타일 설정
          ),
        )
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 5,
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('【物件名】',style: TextStyle(fontSize: 18),),
                    SizedBox(width: 10,),
                    Icon(CupertinoIcons.building_2_fill),
                  ],
                ),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          hintText: "入力お願いします。",border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                    ),
                  ),
                ),
                Text('  -タイトルを作成してください。',style: TextStyle(color: Colors.black54),),
                SizedBox(height:30.0,),
                Row(
                  children: [
                    Text('【住所名】',style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10),
                    Icon(Icons.room),
                  ],
                ),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _PointController,
                      decoration: InputDecoration(
                          hintText: "入力お願いします。",border: InputBorder.none),
                      style: TextStyle(fontSize: 18
                      ),
                    ),
                  ),
                ),
                Text('  -グーグルマップに検索可能なアドレスを',style: TextStyle(color: Colors.black54),),
                Text('   入力してください。',style: TextStyle(color: Colors.black54),),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Text('【担当者】',style: TextStyle(fontSize: 18),),
                    SizedBox(width: 10),
                    Icon(Icons.hail),
                  ],
                ),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _NameController,
                      decoration: InputDecoration(
                          hintText: "入力お願いします。",border: InputBorder.none),
                      style: TextStyle(fontSize: 18
                      ),
                    ),
                  ),
                ),
                Text('  -担当者を入力してください。',style: TextStyle(color: Colors.black54),),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Text('【お客】',style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10),
                    Icon(Icons.handshake_outlined),
                  ],
                ),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _OnerController,
                      decoration: InputDecoration(
                          hintText: "入力お願いします。",border: InputBorder.none),
                      style: TextStyle(fontSize: 18
                      ),
                    ),
                  ),
                ),
                Text('  -お客様、会社名を作成してください。',style: TextStyle(color: Colors.black54),),

                SizedBox(
                  height: 30.0,
                ),
                Text('【時間】',style: TextStyle(fontSize: 18)),
                Container(width:250,
                    child: Text(date,style: TextStyle(fontSize: 18),maxLines: 1,)),
                SizedBox(
                  height: 30.0,
                ),
                Text('【物件内容】',style: TextStyle(fontSize: 18)),
                  Container(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 12.0),
                      child: TextField(
                        controller: _mainController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            hintText: "入力お願いします。"),
                      ),
                    ),
                  ),
                Text('  -メモを始めてください。',style: TextStyle(color: Colors.black54),),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () async {
          if (_titleController.text.isEmpty) {
            // 타이틀이 비어있는 경우
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Error!",style: TextStyle(color: Colors.white),),
                      Container(width: 180,height: 1,color: Colors.white,)
                    ],
                  ),
                  content: Text("タイトルを作成してください.",style: TextStyle(color: Colors.white),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );
          } else {
            // 타이틀이 비어있지 않은 경우 저장
            FirebaseFirestore.instance
                .collection("FirstPage")
                .doc(date)
                .set({
              Title: _titleController.text,
              day: date,
              Point: _PointController.text,
              content: _mainController.text,
              Name: _NameController.text,
              Oner: _OnerController.text,
              // isChecked: "false",
              // isArm: "true",
            })
                .then((value) {
              Navigator.pop(context);
            })
                .catchError((error) => print('뭔가 잘못됬어 찾아봐'));
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

