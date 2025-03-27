import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class AddNoticePage extends StatefulWidget {
  @override
  _AddNoticePageState createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  final TextEditingController titleController = TextEditingController();
  bool isLoading = false;

  final QuillController _quillController = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _quillController.dispose();
    super.dispose();
  }

  void _saveNotice() async {
    if (titleController.text.isEmpty || _quillController.document.isEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("タイトルと内容を入力してください。")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection("Notice").add({
        "title": titleController.text,
        "content": _quillController.document.toDelta().toJson(),
        "date": Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("お知らせが保存されました。")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("保存中にエラーが発生しました: $e")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff003f62),
        title: Text("お知らせ作成", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("タイトル", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "タイトルを入力してください",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            Text("内容", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            Container(
              height: 300,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: _quillController,
                    configurations: const QuillSimpleToolbarConfigurations(),
                  ),
                  Expanded(
                    child: QuillEditor.basic(
                      controller: _quillController,
                      configurations: const QuillEditorConfigurations(),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _saveNotice,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text("保存する"),
            ),
          ],
        ),
      ),
    );
  }
}
