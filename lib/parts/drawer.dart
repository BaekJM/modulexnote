import 'package:ModulexNote/LadderList/Ladder_firestpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../LadderList/CalendarPage.dart';
import '../PageParch1/FirstPage.dart';
import 'SideManu.dart';

class Drawer_otion extends StatefulWidget {
  const Drawer_otion({super.key});

  @override
  State<Drawer_otion> createState() => _Drawer_otionState();
}

class _Drawer_otionState extends State<Drawer_otion> {
  String _nickname = ""; // 닉네임 저장 변수
  bool _isEditing = false; // 닉네임 수정 모드 여부
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserNickname();
  }

  /// 🔹 현재 로그인한 유저의 닉네임 가져오기
  Future<void> _getUserNickname() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email) // ✅ 이메일 기준으로 유저 데이터 가져오기
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        String? nickname = data['nickname'];

        if (nickname != null) {
          setState(() {
            _nickname = nickname;
            _nicknameController.text = nickname;
          });
        }
      }
    } catch (e) {
      print("🔥 닉네임 불러오기 오류: $e");
    }
  }

  /// 🔹 닉네임을 Firestore에 업데이트
  Future<void> _updateNickname() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _nicknameController.text.isEmpty) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .update({'nickname': _nicknameController.text});

      setState(() {
        _nickname = _nicknameController.text;
        _isEditing = false; // 수정 모드 해제
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ニックネームが更新されました！"), backgroundColor: Colors.green),
      );
    } catch (e) {
      print("🔥 닉네임 업데이트 오류: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF013B5E),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modulex',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    if (_isEditing)
                      Expanded(
                        child: TextField(
                          controller: _nicknameController,
                          style: TextStyle(color: Colors.white), // ✅ 텍스트 색상을 흰색으로 변경
                          decoration: InputDecoration(
                            hintText: "ニックネームを入力",
                            hintStyle: TextStyle(color: Colors.white70), // ✅ 힌트 텍스트도 흰색(약간 흐리게)
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white), // ✅ 테두리를 흰색으로 변경
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white), // ✅ 비활성 상태에서도 흰색 테두리 유지
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white, width: 2), // ✅ 포커스 시 흰색 강조
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      )

                    else
                      Text(
                        _nickname.isNotEmpty ? _nickname : "",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    IconButton(
                      icon: Icon(_isEditing ? Icons.published_with_changes : Icons.edit, color: _isEditing ? Colors.green : Colors.white),
                      onPressed: () {
                        if (_isEditing) {
                          _updateNickname(); // ✅ 닉네임 저장
                        } else {
                          setState(() {
                            _isEditing = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SideMenu(parentContext: context)
        ],
      ),
    );
  }
}
