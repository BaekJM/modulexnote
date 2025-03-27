import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ModulexNote/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LadderList/CalendarPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PageParch1/FirstPage.dart';
import 'PageParch1/Manual/Manualpage.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('ja', null);
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkUserLoginState();
  }

  /// 🔹 로그인 상태 확인 후 자동으로 페이지 이동
  void _checkUserLoginState() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // ✅ 로그인된 경우 자동으로 CalendarPage 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      title: 'Modulex Connect',
      home: FirstPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String _lastEmail = ''; // 마지막으로 입력한 이메일 저장
  bool isChecked = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    _getLastEmail(); // 저장된 이메일 불러오기
    _loadCheckBoxState();
  }

  void _loadCheckBoxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool('isChecked') ?? false;
    });
  }

  Future<void> _getLastEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastEmail = prefs.getString('lastEmail') ?? '';
    });
  }

  void _updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }


  /// 🔹 이메일/비밀번호 로그인
  Future<void> _login(BuildContext context) async {
    try {
      // ✅ 로그인 상태 유지 설정
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: "modulex@modulex.jp",
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CalendarPage()),
      );
    } on FirebaseAuthException {
      _updateErrorMessage('Please check Password');
    }
  }


  /// 🔹 Google 로그인 (웹 전용)
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      User? user = userCredential.user;

      if (user != null) {
        await _checkUserRegistration(user);
      } else {
        _updateErrorMessage('Googleログイン失敗:ユーザー情報なし');
      }
    } catch (e) {
      _updateErrorMessage('Googleログイン失敗');
    }
  }

  /// 🔹 Firestore에서 등록 여부 확인 후 페이지 이동
  Future<void> _checkUserRegistration(User user) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.email).get();

      if (userDoc.exists && userDoc['registered'] == true) {
        // 🔥 이미 등록된 사용자라면 바로 CalendarPage로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage()),
        );
      } else {
        // 🔥 등록되지 않은 사용자라면 Login_Edit로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login_Edit()),
        );
      }
    } catch (e) {
      _updateErrorMessage('Firestoreユーザー登録確認失敗');
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isChecked) {
      _emailController.text = '';
    } else {
      _emailController.text = _lastEmail;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500), // 최대 너비 500px 제한
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset('poto/logo3.png'),
                    Text('TS'),
                  ],
                ),
                SizedBox(height: 32),
                // 🔹 고정된 이메일을 TextField 스타일로 변경
                TextField(
                  controller: TextEditingController(text: "modulex@modulex.jp"), // ✅ 고정된 이메일
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(), // ✅ 테두리 추가 (비밀번호 필드와 동일)
                    prefixIcon: Icon(Icons.lock, color: Colors.blue), // ✅ 이메일 아이콘 추가
                    enabled: false, // ✅ 입력 불가능하게 설정
                  ),
                  style: TextStyle(color: Colors.black), // ✅ 고정된 텍스트 색상 유지
                ),
                SizedBox(height: 16),

// 🔹 비밀번호 입력 필드
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // 🔹 일반 로그인 버튼
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _login(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF013B5E)),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                          child: Text('管理者 Login', style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                      Text("追加&管理をされる方は管理者ログインによるログインをお願いします。",style: TextStyle(fontSize: 12,color: Colors.black54),),
                      SizedBox(height: 16),
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 40),
                      // 🔹 웹에서만 Google 로그인 버튼 표시
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () async {
                              await _signInWithGoogle(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // 흰색 배경
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                side: BorderSide(color: Colors.grey), // 테두리 추가
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                              elevation: 0, // 그림자 제거
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "poto/google_logo.png",
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Google Login',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Text("一般社員は、Google ログインによる使用を推奨します。",style: TextStyle(fontSize: 12,color: Colors.black54),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class Login_Edit extends StatefulWidget {
  const Login_Edit({super.key});

  @override
  _LoginEditState createState() => _LoginEditState();
}

class _LoginEditState extends State<Login_Edit> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  String _dailyCode = ''; // Firebase에서 가져오는 8자리 랜덤 코드
  String _errorMessage = '';
  bool _isLoading = true; // Firebase에서 데이터 로딩 중 상태

  @override
  void initState() {
    super.initState();
    _fetchDailyCode(); // Firebase에서 인증 코드 가져오기
  }

  /// 🔹 Firebase에서 오늘 날짜의 8자리 코드 가져오기
  Future<void> _fetchDailyCode() async {
    setState(() {
      _isLoading = true;
    });

    String today = DateTime.now().toLocal().toString().split(' ')[0]; // YYYY-MM-DD 형식
    DocumentSnapshot doc = await _firestore.collection('daily_codes').doc(today).get();

    if (doc.exists) {
      setState(() {
        _dailyCode = doc['code']; // Firestore에서 가져온 코드
        _isLoading = false;
      });
    } else {
      setState(() {
        _dailyCode = '00000000'; // 코드가 없으면 기본값
        _isLoading = false;
      });
    }
  }

  /// 🔹 입력값 검증 및 Firebase에 닉네임 + 등록 상태 저장
  Future<void> _saveUserData() async {
    if (_codeController.text != _dailyCode) {
      setState(() {
        _errorMessage = '認証コードが間違っています。';
      });
      return;
    }

    if (_nicknameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'ニックネームを入力してください。';
      });
      return;
    }

    User? user = _auth.currentUser;
    if (user == null) {
      setState(() {
        _errorMessage = 'ログインされていません。';
      });
      return;
    }

    // Firestore에서 기존 유저 데이터 확인
    DocumentReference userDoc = _firestore.collection('users').doc(user.email);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      // 기존 유저 데이터가 있으면 `registered`를 true로 변경
      await userDoc.update({
        'nickname': _nicknameController.text,
        'registered': true,
      });
    } else {
      // 신규 유저면 `registered: true` 포함해서 생성
      await userDoc.set({
        'nickname': _nicknameController.text,
        'email': user.email,
        'registered': true, // 등록 완료 상태
      });
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', _nicknameController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ニックネームと認証コードが登録されました！'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ユーザー登録', style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body:  Center(
        child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500), // 최대 너비 500px 제한
    child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator() // 🔄 Firebase에서 코드 불러오는 중
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🔹 인증 코드 안내 박스
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: Column(
                  children: [
                    if (DateTime.now().isBefore(DateTime(2025, 5, 1))) ...[ // 🔥 3월 말까지 인증 코드 표시
                      Text(
                        '本日の認証コード',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),Text(
                        '4月末まで認証コード表示',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _dailyCode,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ] else ...[
                      // 🔥 4월 1일부터 안내 문구 표시
                      Text(
                        '登録済みのユーザーに認証コードを聞いてログインを進めてください。',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 24),


              /// 🔹 닉네임 입력 필드
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  labelText: 'ニックネームを入力',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                ),
              ),
              SizedBox(height: 16),

              /// 🔹 인증 코드 입력 필드
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: '8桁の認証コードを入力',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Colors.blue),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              /// 🔹 오류 메시지 출력
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              SizedBox(height: 16),

              /// 🔹 등록 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveUserData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    '登録する',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        ),
      ),
    );
  }
}

