import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';

import '../../../parts/ListParch.dart';

class NewsWrite extends StatefulWidget {
  const NewsWrite({Key? key}) : super(key: key);

  @override
  State<NewsWrite> createState() => _NewsWriteState();
}

class _NewsWriteState extends State<NewsWrite> {
  int currentPage = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _PointController = TextEditingController();
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _OnerController = TextEditingController();

  String date = DateTime.now().toString();
  bool isLoading = false;
  bool isFilled6page = false;

  List<PlatformFile> selectedImages = [];
  PlatformFile? selectedPdf;
  late quill.QuillController quillController;

  @override
  void initState() {
    super.initState();
    quillController = quill.QuillController.basic();
  }

  void _nextPage() {
    if (currentPage == 0 && _titleController.text.trim().isEmpty) {
      _showMessage("タイトルを入力してください。");
      return;
    }
    if (currentPage == 1 && _PointController.text.trim().isEmpty) {
      _showMessage("住所を入力してください。");
      return;
    }
    if (currentPage == 2 && _NameController.text.trim().isEmpty) {
      _showMessage("担当者を入力してください。");
      return;
    }
    if (currentPage == 3 && _OnerController.text.trim().isEmpty) {
      _showMessage("お客様名を入力してください。");
      return;
    }
    if (currentPage == 4 && quillController.document.isEmpty()) {
      _showMessage("物件内容を入力してください。");
      return;
    }
    if (currentPage == 4) {
      setState(() {
        isFilled6page = true;
      });
    }

    if (currentPage < 6) {
      setState(() => currentPage++);
    } else {
      _saveProject();
    }
  }

  void _prevPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );
      if (result != null) {
        setState(() => selectedImages = result.files);
      }
    } catch (e) {
      _showMessage("画像選択エラー: $e");
    }
  }

  Future<void> pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );
      if (result != null) {
        setState(() => selectedPdf = result.files.single);
      }
    } catch (e) {
      _showMessage("PDF選択エラー: $e");
    }
  }

  Future<void> _saveProject() async {
    setState(() => isLoading = true);

    try {
      List<String> uploadedImageUrls = [];

      for (var file in selectedImages) {
        final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        final ref = FirebaseStorage.instance.ref(fileName);

        UploadTask uploadTask = kIsWeb
            ? ref.putData(file.bytes!)
            : ref.putFile(File(file.path!));

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        uploadedImageUrls.add(downloadUrl);
      }

      String pdfDownloadUrl = '';
      if (selectedPdf != null) {
        final pdfName = 'pdfs/${DateTime.now().millisecondsSinceEpoch}_${selectedPdf!.name}';
        final ref = FirebaseStorage.instance.ref(pdfName);

        UploadTask pdfTask = kIsWeb
            ? ref.putData(selectedPdf!.bytes!)
            : ref.putFile(File(selectedPdf!.path!));

        final snapshot = await pdfTask;
        pdfDownloadUrl = await snapshot.ref.getDownloadURL();
      }

      final contentJson = quillController.document.toDelta().toJson();

      await FirebaseFirestore.instance.collection("FirstPage").doc(date).set({
        "title": _titleController.text,
        "day": date,
        "Point": _PointController.text,
        "Name": _NameController.text,
        "Oner": _OnerController.text,
        "content": contentJson,
        "imageUrls": uploadedImageUrls,
        "pdfUrl": pdfDownloadUrl,
        "category": selectedCategory, // ✅ 카테고리 저장
      });


      _showMessage("保存が完了しました！");
      Navigator.pop(context);
    } catch (e) {
      _showMessage("保存中にエラーが発生しました: $e");
    }

    setState(() => isLoading = false);
  }

  Widget _getPage() {
    switch (currentPage) {
      case 0:
        return _buildTextInput("【物件名】", _titleController, "タイトルを作成してください。");
      case 1:
        return _buildTextInput("【住所】", _PointController, "GoogleMapに検索できる住所を入力してください。");
      case 2:
        return _buildTextInput("【担当者】", _NameController, "担当者名を入力してください。");
      case 3:
        return _buildTextInput("【お客様名】", _OnerController, "会社名・顧客名を入力してください。");
      case 4:
        return _buildContentPage();
      case 5:
        return _buildFilePage();
      case 6:
        return _buildConfirmPage();
      default:
        return Container();
    }
  }

  Widget _buildTextInput(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
          ),
        ),
        if (label == "【物件名】") // 🔥 category 선택은 첫 페이지에만 표시
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("カテゴリを選択:", style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['value'],
                      child: Row(
                        children: [
                          Icon(category['icon'], size: 20),
                          SizedBox(width: 8),
                          Text(category['label']),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }


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

  Widget _buildFilePage() => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("📷 画像アップロード", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ElevatedButton.icon(
          onPressed: pickImages,
          icon: Icon(Icons.image),
          label: Text("画像を選択"),
        ),
        SizedBox(height: 10),
        if (selectedImages.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                final file = selectedImages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: kIsWeb
                      ? Image.memory(file.bytes!, width: 100, height: 100, fit: BoxFit.cover)
                      : Image.file(File(file.path!), width: 100, height: 100, fit: BoxFit.cover),
                );
              },
            ),
          ),
        Divider(height: 30),
        Text("📄 PDFアップロード", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ElevatedButton.icon(
          onPressed: pickPdf,
          icon: Icon(Icons.picture_as_pdf),
          label: Text("PDFファイルを選択"),
        ),
        if (selectedPdf != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("📄 選択されたPDF: ${selectedPdf!.name}", style: TextStyle(color: Colors.green)),
          ),
      ],
    ),
  );



  Widget _buildConfirmPage() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("✅ 以下の内容で保存しますか？", style: TextStyle(fontSize: 18)),
        Divider(),
        Text("【物件名】: ${_titleController.text}"),
        Text("【住所】: ${_PointController.text}"),
        Text("【担当者】: ${_NameController.text}"),
        Text("【お客様】: ${_OnerController.text}"),
        Text("【時間】: $date"),
        SizedBox(height: 10),
        Text("【物件内容】:"),
        Container(
          height: 300, // 또는 MediaQuery로 유동적으로 조절 가능
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: quill.QuillEditor(
            controller: quillController,
            scrollController: ScrollController(),
            focusNode: FocusNode(),
          ),
        ),
        SizedBox(height: 10),
        Text("📷 画像数: ${selectedImages.length}"),
        Text("📄 PDF: ${selectedPdf?.name ?? 'なし'}"),
      ],
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xff003f62),
          title: Text("プロジェクト作成")
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  bool isFilled = false;

                  switch (index) {
                    case 0:
                      isFilled = _titleController.text.trim().isNotEmpty;
                      break;
                    case 1:
                      isFilled = _PointController.text.trim().isNotEmpty;
                      break;
                    case 2:
                      isFilled = _NameController.text.trim().isNotEmpty;
                      break;
                    case 3:
                      isFilled = _OnerController.text.trim().isNotEmpty;
                      break;
                    case 4:
                      isFilled = !quillController.document.isEmpty();
                      break;
                    case 5:
                      isFilled = isFilled6page;
                      break;
                    case 6:
                      isFilled = isFilled6page;
                      break;
                  }

                  Color backgroundColor;
                  if (index == currentPage) {
                    backgroundColor = Colors.amber;
                  } else if (isFilled) {
                    backgroundColor = Colors.amberAccent;
                  } else {
                    backgroundColor = Colors.grey.shade300;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: isFilled
                          ? () {
                        setState(() {
                          currentPage = index;
                        });
                      }
                          : null,
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: index == currentPage ? Colors.black : Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: _getPage()),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _prevPage,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.orange),
                        foregroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("戻る", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                if (currentPage > 0) SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      currentPage == 6 ? "保存する" : "次へ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}