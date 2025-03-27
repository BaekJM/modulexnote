import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class NewsWrite extends StatefulWidget {
  const NewsWrite({Key? key}) : super(key: key);

  @override
  State<NewsWrite> createState() => _NewsWriteState();
}

class _NewsWriteState extends State<NewsWrite> {
  String date = DateTime.now().toString();

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

  List<PlatformFile> selectedImages = [];
  PlatformFile? selectedPdf;
  bool isLoading = false;

  Future<void> pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (result != null) {
        setState(() {
          selectedImages = result.files;
        });
      }
    } catch (e) {
      print("🔥 이미지 선택 오류: $e");
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
        setState(() {
          selectedPdf = result.files.single;
        });
      }
    } catch (e) {
      print("🔥 PDF 선택 오류: $e");
    }
  }

  Widget buildImagePreview() {
    if (selectedImages.isEmpty) return SizedBox();

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedImages.length,
        itemBuilder: (context, index) {
          final image = selectedImages[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: kIsWeb
                ? Image.memory(image.bytes!, width: 150, height: 150, fit: BoxFit.cover)
                : Image.file(File(image.path!), width: 150, height: 150, fit: BoxFit.cover),
          );
        },
      ),
    );
  }

  Future<void> saveProject() async {
    if (_titleController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            title: Text("Error!", style: TextStyle(color: Colors.white)),
            content: Text("タイトルを作成してください.", style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      List<String> uploadedImageUrls = [];

      for (var file in selectedImages) {
        final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        UploadTask task;

        if (kIsWeb) {
          task = FirebaseStorage.instance.ref(fileName).putData(file.bytes!);
        } else {
          task = FirebaseStorage.instance.ref(fileName).putFile(File(file.path!));
        }

        TaskSnapshot snapshot = await task;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        uploadedImageUrls.add(downloadUrl);
      }

      String pdfDownloadUrl = '';
      if (selectedPdf != null) {
        final pdfName = 'pdfs/${DateTime.now().millisecondsSinceEpoch}_${selectedPdf!.name}';
        UploadTask pdfTask;

        if (kIsWeb) {
          pdfTask = FirebaseStorage.instance.ref(pdfName).putData(selectedPdf!.bytes!);
        } else {
          pdfTask = FirebaseStorage.instance.ref(pdfName).putFile(File(selectedPdf!.path!));
        }

        TaskSnapshot snapshot = await pdfTask;
        pdfDownloadUrl = await snapshot.ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection("FirstPage").doc(date).set({
        Title: _titleController.text,
        day: date,
        Point: _PointController.text,
        content: _mainController.text,
        Name: _NameController.text,
        Oner: _OnerController.text,
        "imageUrls": uploadedImageUrls,
        "pdfUrl": pdfDownloadUrl,
      });

      Navigator.pop(context);
    } catch (e) {
      print("🔥 저장 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("저장 중 오류 발생: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Add New Project", style: TextStyle(fontFamily: 'CustomFont', fontSize: 25.0, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF013B5E), Color(0xFF63CAFF)],
              ),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목 입력
                Row(children: [Text('【物件名】', style: TextStyle(fontSize: 18)), SizedBox(width: 10), Icon(CupertinoIcons.building_2_fill)]),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: "入力お願いします。", border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    ),
                  ),
                ),
                Text('  -タイトルを作成してください。', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 30),

                // 주소 입력
                Row(children: [Text('【住所名】', style: TextStyle(fontSize: 18)), SizedBox(width: 10), Icon(Icons.room)]),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _PointController,
                      decoration: InputDecoration(hintText: "入力お願いします。", border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text('  -グーグルマップに検索可能なアドレスを\n   入力してください。', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 30),

                // 담당자
                Row(children: [Text('【担当者】', style: TextStyle(fontSize: 18)), SizedBox(width: 10), Icon(Icons.hail)]),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _NameController,
                      decoration: InputDecoration(hintText: "入力お願いします。", border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text('  -担当者を入力してください。', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 30),

                // 고객명
                Row(children: [Text('【お客】', style: TextStyle(fontSize: 18)), SizedBox(width: 10), Icon(Icons.handshake_outlined)]),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _OnerController,
                      decoration: InputDecoration(hintText: "入力お願いします。", border: InputBorder.none),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text('  -お客様、会社名を作成してください。', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 30),

                // 시간
                Text('【時間】', style: TextStyle(fontSize: 18)),
                Container(width: 250, child: Text(date, style: TextStyle(fontSize: 18), maxLines: 1)),
                SizedBox(height: 30),

                // 본문
                Text('【物件内容】', style: TextStyle(fontSize: 18)),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
                    child: TextField(
                      controller: _mainController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(border: InputBorder.none, hintText: "入力お願いします。"),
                    ),
                  ),
                ),
                Text('  -メモを始めてください。', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 30),

                // 이미지 & PDF 업로드
                ElevatedButton(onPressed: pickImages, child: Text("📷 이미지 여러 장 선택")),
                buildImagePreview(),
                SizedBox(height: 10),
                ElevatedButton(onPressed: pickPdf, child: Text("📄 PDF 선택")),
                if (selectedPdf != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("📄 선택된 PDF: ${selectedPdf!.name}", style: TextStyle(color: Colors.green)),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: isLoading
          ? CircularProgressIndicator()
          : FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: saveProject,
        child: Icon(Icons.save),
      ),
    );
  }
}
