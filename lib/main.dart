import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ModuleXNote/meessaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FirstPage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
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
  String _errorMessage = ''; // 에러 메시지를 저장할 변수

  // 에러 메시지 업데이트 메서드
  void _updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  // 로그인 시도 메서드
  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 로그인 성공 시, 홈 페이지로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirstPage(),
        ),
      );

      // 사용자 이메일을 해싱하여 사용자 식별자로 사용
      String userEmail = _emailController.text;

      // Firestore에 즐겨찾기 목록 저장 예시
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .set({
        'day': FieldValue.arrayUnion([userEmail]),
      });
    } on FirebaseAuthException catch (e) {
      print('로그인 실패: $e');
      _updateErrorMessage('Please check ID/Password'); // 에러 메시지 업데이트
    }
  }

  @override
  void dispose() {
    // 화면이 종료될 때 컨트롤러 및 에러 메시지 초기화
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              _errorMessage, // 에러 메시지 표시
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
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