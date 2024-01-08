import 'package:modulexts/meessaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FirstPage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';


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
      home: const FirstPage()
    );
  }
}
