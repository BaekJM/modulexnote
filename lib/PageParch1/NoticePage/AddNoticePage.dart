import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;


class AddNoticeWizard extends StatefulWidget {
  @override
  _AddNoticeWizardState createState() => _AddNoticeWizardState();
}

class _AddNoticeWizardState extends State<AddNoticeWizard> {
  int currentPage = 0;

  final TextEditingController titleController = TextEditingController();
  final QuillController quillController = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  bool isLoading = false;

  void _nextPage() {
    if (currentPage == 0) {
      if (titleController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("タイトルを入力してください。")),
        );
        return;
      }
    }

    if (currentPage == 1) {
      if (quillController.document.isEmpty()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("内容を入力してください。")),
        );
        return;
      }
    }

    if (currentPage < 2) {
      setState(() {
        currentPage++;
      });
    } else {
      _saveNotice();
    }
  }


  void _prevPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void _saveNotice() async {
    if (titleController.text.isEmpty || quillController.document.isEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("タイトルと内容を入力してください。")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection("Notice").add({
        "title": titleController.text,
        "content": quillController.document.toDelta().toJson(),
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

    setState(() => isLoading = false);
  }

  Widget _buildTitlePage() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("📌 タイトルを入力してください", style: TextStyle(fontSize: 18)),
      SizedBox(height: 40),
      TextField(
        controller: titleController,
        decoration: InputDecoration(
          hintText: "例: サーバーメンテナンスのお知らせ",
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );


  Widget _buildContentPage() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("📝 内容を入力してください", style: TextStyle(fontSize: 18)),
      SizedBox(height: 10),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                QuillSimpleToolbar(
                  controller: quillController,
                  configurations: const QuillSimpleToolbarConfigurations(),
                ),
                Expanded(
                  child: QuillEditor.basic(
                    controller: quillController,
                    configurations: const QuillEditorConfigurations(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );


  Widget _buildConfirmPage() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("✅ この内容で保存しますか？", style: TextStyle(fontSize: 18)),
      SizedBox(height: 20),
      Text("${titleController.text}", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      SizedBox(height: 10),
      Container(
        height: 200,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: QuillEditor.basic(
          controller: quillController,
          configurations: const QuillEditorConfigurations(),
        ),
      ),
    ],
  );


  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentPage) {
      case 0:
        page = _buildTitlePage();
        break;
      case 1:
        page = _buildContentPage();
        break;
      case 2:
        page = _buildConfirmPage();
        break;
      default:
        page = Container();
    }

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
            Expanded(child: page),
            Row(
              children: [
                if (currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _prevPage,
                      child: Text("戻る"),
                    ),
                  ),
                SizedBox(width: 10),
                Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(currentPage == 2 ? "保存する" : "次へ"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
