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
              Icon(Icons.notifications_none),
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Add New News"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('【物件名】'),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: "入力お願いします。"),
                  style: TextStyle(fontSize: 18),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                ),
                SizedBox(height: 40.0,),
                Text('【住所名】'),
                TextField(
                  controller: _PointController,
                  decoration: InputDecoration(
                      hintText: "入力お願いします。"),
                  style: TextStyle(fontSize: 18
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('【担当者】'),
                TextField(
                  controller: _NameController,
                  decoration: InputDecoration(
                      hintText: "入力お願いします。"),
                  style: TextStyle(fontSize: 18
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('【お客】'),
                TextField(
                  controller: _OnerController,
                  decoration: InputDecoration(
                      hintText: "入力お願いします。"),
                  style: TextStyle(fontSize: 18
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('【時間】'),
                Container(width:250,
                    child: Text(date,style: TextStyle(fontSize: 18),)),
                SizedBox(
                  height: 30.0,
                ),
                Text('【物件内容】'),
                TextField(
                  controller: _mainController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "入力お願いします。"),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () async {
          FirebaseFirestore.instance
              .collection("FirstPage")
              .doc(date)
              .set({
            Title: _titleController.text,
            day: date,
            Point:_PointController.text,
            content: _mainController.text,
            Name: _NameController.text,
            Oner: _OnerController.text,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((error) => print('뭔가 잘못됬어 찾아봐'));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

