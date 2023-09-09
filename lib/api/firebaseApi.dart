import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
    print('Title ${message.notification?.title}');
    print('Body ${message.notification?.body}');
    print('Payload ${message.data}');
}


class FirebaseApi {
  final firebaseMessage = FirebaseMessaging.instance;

  Future <void> initNotification () async{

    await firebaseMessage.requestPermission();
    final fcmToken = await firebaseMessage.getToken();
    print('token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}