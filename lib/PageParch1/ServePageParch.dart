import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget ServePageParch(Function()? onTap, QueryDocumentSnapshot doc) {
  String Title = "title";
  String day = "day";
  String content = "content";
  String _Point = "_Point";
  String Name = "Name";
  String ColorR = "ColorR";
  String ColorX = "ColorX";
  String ColorT = "ColorT";
  String ColorB = "ColorB";


  var PopString = doc[ColorR];
  final Popbuffer = StringBuffer();
  Popbuffer.write(PopString.replaceFirst('0x', ''));

  var PopRedString = doc[ColorX];
  final PopRedbuffer = StringBuffer();
  PopRedbuffer.write(PopRedString.replaceFirst('0x', ''));

  var ColorTRedString = doc[ColorT];
  final ColorTbuffer = StringBuffer();
  ColorTbuffer.write(ColorTRedString.replaceFirst('0x', ''));

  var ColorBRedString = doc[ColorB];
  final ColorBbuffer = StringBuffer();
  ColorBbuffer.write(ColorBRedString.replaceFirst('0x', ''));

  return InkWell(
    onTap: onTap,
    child: Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.only(left: 8.0,right: 8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Color(int.parse(PopRedbuffer.toString(), radix: 16)),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 3,color: Color(int.parse(Popbuffer.toString(), radix: 16)))),
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
                  Text(
                    doc[Title],
                    style: TextStyle(fontSize: 20,
                      color: Color(int.parse(ColorTbuffer.toString(), radix: 16))
                    ),
                  ),
                  Container(width: 200, height: 2, color: Color(int.parse(ColorBbuffer.toString(),radix: 16))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    child: Text(
                      doc[content],
                      style: TextStyle(fontSize: 14,
                          color: Color(int.parse(ColorTbuffer.toString(), radix: 16))),
                      maxLines: 1,
                    ),
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
                doc[_Point],
                style: TextStyle(fontSize: 13,color: Color(int.parse(ColorTbuffer.toString(), radix: 16))),
              ),
              Container(
                width: 80,
                child: Text(
                  doc[day],
                  style: TextStyle(fontSize: 10,color: Color(int.parse(ColorTbuffer.toString(), radix: 16))),
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

const List<String> list = <String>['Nomar', '重要', '不具合', '変更', '以外'];

class ServePageWrite extends StatefulWidget {
  ServePageWrite(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  State<ServePageWrite> createState() => _ServePageWriteState();
}

class _ServePageWriteState extends State<ServePageWrite> {
  String date = DateTime.now().toString();

  ///아마 시간대 불러오는 코드인듯
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  TextEditingController _AramController = TextEditingController();
  TextEditingController _NameController = TextEditingController();

  String Title = "title";
  String day = "day";
  String content = "content";
  String Aram = "Aram";
  String Name = "Name";

  String _Point = list.first;

  String ColorR = "ff223344";
  String ColorX = "ffffffff";
  String ColorT = "ff000000";
  String ColorB = "ff000000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Add New Note",
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
                Text('【メモ名】',style: TextStyle(fontSize: 18),),
                Container(
                 color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: "入力お願いします。",border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text('  -メモのタイトルを入力してください.',style: TextStyle(color: Colors.black54),),
                SizedBox(
                  height: 40.0,
                ),
                Text('【重要度】',style: TextStyle(fontSize: 18),),
                Container(
                  width: double .infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: DropdownButton<String>(
                      value: _Point,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? New_Point) {
                        setState(() {
                          _Point = New_Point!;
                          if (_Point == 'Nomar' && _Point == '以外') {
                            ColorR = "ffffffff";
                            ColorX = "ffffffff";
                            ColorT = "ff000000";
                            ColorB = "ff000000";
                          } else if (_Point == '重要') {
                            ColorR = "ffBB4642";
                            ColorX = "ffBB4642";
                            ColorT = "ffffffff";
                            ColorB = "ffffffff";
                          } else if (_Point == '不具合') {
                            ColorR = "ffBB4642";
                            ColorX = "ffffffff";
                            ColorT = "ff000000";
                            ColorB = "ffBB4642";
                          } else if (_Point == '変更') {
                            ColorR = "FFE2CD26";
                            ColorX = "ffffffff";
                            ColorT = "ff000000";
                            ColorB = "FFE2CD26";
                          }
                        });
                      },
                      items: list
                          .map<DropdownMenuItem<String>>((String New_Point) {
                        return DropdownMenuItem<String>(
                          value: New_Point,
                          child: Text(New_Point),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Text('  -メモのタイプを選んでください.',style: TextStyle(color: Colors.black54),),
                SizedBox(
                  height: 30.0,
                ),
                Text('【担当者】',style: TextStyle(fontSize: 18),),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _NameController,
                      decoration: InputDecoration(hintText: "入力お願いします。",border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text('  -作成者を入力してください.',style: TextStyle(color: Colors.black54),),
                SizedBox(
                  height: 30.0,
                ),
                Text('【時間】',style: TextStyle(fontSize: 18),),
                Container(
                    width: 200,
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 18),
                      maxLines: 1,
                    )),
                Text('  年-月-日',style: TextStyle(color: Colors.black54),),
                SizedBox(
                  height: 30.0,
                ),
                Text('【内容】',style: TextStyle(fontSize: 18),),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 12.0),
                    child: TextField(
                      controller: _mainController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(hintText: "入力お願いします。",border: InputBorder.none),
                    ),
                  ),
                ),
                Text('  -メモを始めてください。',style: TextStyle(color: Colors.black54),),
                Text('  -内容は後日続けて作成できますので、',style: TextStyle(color: Colors.black54),),
                Text('   ご心配なく簡単に作成して保存してください。',style: TextStyle(color: Colors.black54),),
                Text('  -空欄にも保存できます。',style: TextStyle(color: Colors.black54),),
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
                      Text("Error",style: TextStyle(color: Colors.white),),
                      Container(width: 180,height: 1,color: Colors.white,)
                    ],
                  ),
                  content: Text("メモのタイトルを入力してください。",style: TextStyle(color: Colors.white),),
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
                .collection(widget.data)
                .doc(date)
                .set({
              Title: _titleController.text,
              day: date,
              "_Point": _Point,
              content: _mainController.text,
              Name: _NameController.text,
              "ColorR": ColorR,
              "ColorX": ColorX,
              "ColorT": ColorT,
              "ColorB": ColorB,
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
