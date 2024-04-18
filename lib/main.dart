import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ModulexNote/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FirstPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences 라이브러리 추가



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      title: 'Flutter Demo',
      home: LoginPage(),
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
  String _lastEmail = ''; // 마지막에 작성한 이메일 주소를 저장할 변수

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _getLastEmail(); // 앱 실행 시 저장된 마지막 이메일 주소 불러오기
    _loadCheckBoxState();
  }

  void _loadCheckBoxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool('isChecked') ?? false;
    });
  }

  void _saveCheckBoxState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isChecked', value);
  }

  // 저장된 마지막 이메일 주소 불러오는 메서드
  Future<void> _getLastEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastEmail = prefs.getString('lastEmail') ?? '';
    });
  }

  // 에러 메시지 업데이트 메서드
  void _updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  // 로그인 시도 메서드


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isChecked == false) {
      _emailController.text = _emailController.text; // 리셋을 원하는 경우
    } else {
      _emailController.text = _lastEmail;
    }

    Future<void> _login(BuildContext context) async {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // 로그인 성공 시, 홈 페이지로 이동

        String userEmail = _emailController.text;

        _lastEmail = userEmail; // 변수에도 저장된 이메일 주소 업데이트

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirstPage(),
          ),
        );

        // Firestore에 즐겨찾기 목록 저장 예시
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userEmail)
            .set({
          'day': FieldValue.arrayUnion([userEmail]),
        });

        // SharedPreferences에 마지막으로 작성한 이메일 주소 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('lastEmail', userEmail);
      } on FirebaseAuthException catch (e) {
        _lastEmail = _emailController.text;
        print('로그인 실패: $e');
        _updateErrorMessage('Please check ID/Password');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
            SizedBox(height: 80),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Login in and Save your Email?"),
              IconButton(onPressed: (){
                setState(() {
                  isChecked = !isChecked;
                  _saveCheckBoxState(isChecked);
                  _lastEmail = "";
                });
              },
                  icon: Icon(
                    isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
              )
            ],),

            ElevatedButton(
              onPressed: () async {
                await _login(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF013B5E)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}