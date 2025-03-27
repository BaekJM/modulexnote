import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditLadder extends StatefulWidget {
  final String documentId; // 수정할 문서의 ID

  const EditLadder({Key? key, required this.documentId}) : super(key: key);

  @override
  State<EditLadder> createState() => _EditLadderState();
}

class _EditLadderState extends State<EditLadder> {
  String _titleController = "";
  String _nameController = "";
  final TextEditingController _pointController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  Color _selectedColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _pointController.dispose();
    _mainController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("Ladder")
          .doc(widget.documentId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          setState(() {
            _titleController = data['title'] ?? '';
            _nameController = data['Name'] ?? '';
            _pointController.text = data['Point'] ?? '';
            _selectedColor = Color(int.parse(data['color'] ?? '0xFF000000'));
            _mainController.text = data['content'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Firestore 데이터 가져오기 오류: $e");
    }
  }

  Future<void> saveChanges() async {
    if (
        _mainController.text.isEmpty ||
        _pointController.text.isEmpty) {
      showErrorDialog("すべての項目を入力してください。");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection("Ladder").doc(widget.documentId).update({
        'Point': _pointController.text,
        'color': _selectedColor.value.toString(),
      });

      Navigator.pop(context);
    } catch (e) {
      print("Firestore 업데이트 오류: $e");
      showErrorDialog("データの更新中にエラーが発生しました。");
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        title: const Text("エラー", style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _openColorPicker() async {
    Color pickedColor = _selectedColor;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("色を選択"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickedColor,
            onColorChanged: (color) {
              pickedColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("キャンセル"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedColor = pickedColor;
              });
              Navigator.pop(context);
            },
            child: const Text("確認"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Ladder List", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("【名前】 : $_titleController", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text("【番号】 : $_nameController", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            buildInputSection("【場所】", "場所を入力してください。", _pointController),
            const SizedBox(height: 16),
            const Text("【色を選択】", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _openColorPicker,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    "色を選択するにはタップしてください。",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildInputSection("【特徴】", "特徴を入力してください。", _mainController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                "保存する",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputSection(String title, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
