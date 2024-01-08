import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class News_Update extends StatefulWidget {
  const News_Update({super.key});

  @override
  State<News_Update> createState() => _News_UpdateState();
}

class _News_UpdateState extends State<News_Update> {

  String date = DateTime.now().toString(); ///아마 시간대 불러오는 코드인듯

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  String Title = "title";
  String day = "day";
  String content = "content";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('고치는 위치'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "News Name"
              ),inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            ),
            SizedBox(height: 8.0,),
            Text(date),
            SizedBox(height: 28.0,),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "News content"
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () async{
          FirebaseFirestore.instance.collection("Add").doc(_titleController.text).set({
            Title:_titleController.text,
            day:date,
            content:_mainController.text
          }).then((value) {
            Navigator.pop(context);
          }).catchError((error) => print('뭔가 잘못됬어 찾아봐'));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}