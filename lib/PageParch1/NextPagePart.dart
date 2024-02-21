import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  NextPage(this.doc, this.data, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  String data;

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String Title = "title";
  String day = "day";
  String content = "content";
  String test = "content";
  String Aram = "Aram";
  String Name = "Name";


  @override
  Widget build(BuildContext context) {
    TextEditingController _mainController = TextEditingController(text: widget.doc[content]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(height: 30, child: Image.asset('poto/logo3.png')),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              bool confirmDelete = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 2.0,
                    title: Text("削除確認"),
                    content: Text("本当にこのノートを削除しますか？"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // true를 반환하여 삭제 수행
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // false를 반환하여 삭제 취소
                        },
                        child: Text("No"),
                      ),
                    ],
                  );
                },
              );

              if (confirmDelete ?? false) {
                // confirmDelete가 null이면 false로 처리
                FirebaseFirestore.instance
                    .collection(widget.data)
                    .doc(widget.doc[day])
                    .delete()
                    .then((value) {
                  Navigator.pop(context);
                }).catchError((error) =>
                    print('뭔가 잘못됬어 삭제를 못하잖아 이유를 찾아봐'));
              }
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body:ListView(
          children: [
            Container(
              color: Color(0xFF013B5E),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doc[Title],
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.doc[Name],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                        widget.doc[day],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) {
                  FirebaseFirestore.instance
                      .collection(widget.data)
                      .doc(widget.doc[Title])
                      .update({
                    content: text,
                  }).then((value) {}).catchError((error) => print('뭔가 잘못됬어 찾아봐'));
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "News content",
                ),
              ),
            ),
          ],
        ),
    );
  }
}
