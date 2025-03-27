import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewsLadder extends StatefulWidget {
  const NewsLadder({Key? key}) : super(key: key);

  @override
  State<NewsLadder> createState() => _NewsLadderState();
}

class _NewsLadderState extends State<NewsLadder> {
  String date = DateTime.now().toString();

  // 텍스트 컨트롤러
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  final TextEditingController _pointController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Color _selectedColor = Colors.grey; // 선택한 색상

  @override
  void dispose() {
    // 컨트롤러 해제
    _titleController.dispose();
    _mainController.dispose();
    _pointController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  /// Firestore에 데이터 저장
  Future<void> saveData() async {
    if (_titleController.text.isEmpty) {
      showErrorDialog("タイトルを作成してください.");
      return;
    }
    if (_nameController.text.isEmpty) {
      showErrorDialog("番号を入力してください.");
      return;
    }
    if (_pointController.text.isEmpty) {
      showErrorDialog("場所を入力してください.");
      return;
    }
    if (_selectedColor == null) {
      showErrorDialog("色を選択してください。");
      return;
    }

    try {
      // Firestore에서 중복 확인
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Ladder")
          .where("Name", isEqualTo: _nameController.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        showErrorDialog("番号が既に存在します。別の番号を入力してください。");
        return;
      }

      String title = "${_titleController.text}_[${_nameController.text}]";

      // 데이터 저장
      await FirebaseFirestore.instance.collection("Ladder").doc(title).set({
        'title': title,
        'day': formatDate(date),
        'Point': _pointController.text,
        'content': _mainController.text,
        'Name': _nameController.text,
        'Oner': "Modulex",
        'color': _selectedColor.value.toString(),
        'id': title,
      });

      Navigator.pop(context);
    } catch (error) {
      print("Firestore 저장 오류: $error");
      showErrorDialog("データの保存中にエラーが発生しました。");
    }
  }

  /// 오류 다이얼로그 표시
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: const Text(
            "エラー",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 색상 선택 다이얼로그
  Future<void> _openColorPicker() async {
    Color pickedColor = _selectedColor;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("色を選択"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (color) {
                pickedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
        );
      },
    );
  }

  /// 날짜 포맷 변환
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Add Ladder List",
          style: TextStyle(
            fontFamily: 'CustomFont',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 이름 입력
          buildInputSection("【名前】", "入力お願いします。", _titleController, maxLength: 20),
          const SizedBox(height: 30.0),

          // 번호 입력
          buildInputSection("【番号】", "番号を入力してください。", _nameController),
          const SizedBox(height: 30.0),

          // 장소 입력
          buildInputSection("【場所】", "場所を入力してください。", _pointController),
          const SizedBox(height: 30.0),

          // 색상 선택
          const Text("【色を選択】", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8.0),
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
          const SizedBox(height: 30.0),
          // 특징 입력
          const Text("【特徴】", style: TextStyle(fontSize: 18)),
          Container(
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "メモを入力してください。",
                ),
              ),
            ),
          ),
          const Text("【登録日】", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8.0),
          Text(formatDate(date), style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 30.0),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: saveData,
        child: const Icon(Icons.save),
      ),
    );
  }

  /// 입력 섹션 생성
  Widget buildInputSection(String title, String hint, TextEditingController controller, {int maxLength = 50}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8.0),
        Container(
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 18),
              inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
            ),
          ),
        ),
      ],
    );
  }
}
