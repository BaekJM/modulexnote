import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi {
  final _firebaseMassaging = FirebaseMessaging.instance;

  Future<void> initNotification() async{
    await _firebaseMassaging.requestPermission();
    final fCMToken = await _firebaseMassaging.getToken();
    print('Token:$fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

