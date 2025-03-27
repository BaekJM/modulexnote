import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeDetailPage extends StatefulWidget {
  final String docId;
  final String title;
  final List<dynamic> contentDelta;
  final DateTime? date;

  const NoticeDetailPage({
    required this.docId,
    required this.title,
    required this.contentDelta,
    this.date,
    super.key,
  });

  @override
  State<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  late QuillController _controller;
  bool _isEditable = false;
  bool _isLoading = false;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document.fromJson(widget.contentDelta),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _titleController = TextEditingController(text: widget.title);
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('Notice').doc(widget.docId).update({
        "title": _titleController.text,
        "content": _controller.document.toDelta().toJson(),
        "date": Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("お知らせが更新されました。")),
      );

      setState(() {
        _isEditable = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("保存中にエラーが発生しました: $e")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = widget.date != null
        ? DateFormat('yyyy.MM.dd HH:mm').format(widget.date!)
        : '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003f62),
        title: const Text("📢 お知らせ詳細", style: TextStyle(color: Colors.white)),
        actions: [
          if (!_isEditable)
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditable = true;
                });
              },
              child: const Text("編集する", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 제목 입력
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xfff1f6fb),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffcfdce7)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  enabled: _isEditable,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    labelText: "タイトル",
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 4),
                Text(formattedDate, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 본문
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xfffdfdfd),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: _controller,
                sharedConfigurations: const QuillSharedConfigurations(),
              ),
            ),
          ),

          if (_isEditable) ...[
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text("保存する"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
