import 'package:bottom_bar/bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:groceryapp/api/firebaseApi.dart';
import 'package:groceryapp/cart.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/orderpage.dart';
import 'package:groceryapp/profilePage.dart';
import 'package:groceryapp/splashScreen.dart';

import 'loginpage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;


    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: "@drawable/logo",
              priority: Priority.max,
              importance: Importance.max,
              enableVibration: true,
              // other properties...
            ),
          ));
    }
  });


  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.instance.getToken().then((value) => print(value));
  FirebaseMessaging.instance.subscribeToTopic("all");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAsMVCStJSVBOLRRSpYUIiDorFnT8YziTk",
          appId: "1:700526240192:ios:9ce1307ed6105bdad52825",
          messagingSenderId: "700526240192",
          projectId: "grocery-app-9b16d"
      )
  );


  //await FirebaseApi().initNotification();
  
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Grocery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffF4F4F3),
        textTheme:
        Theme.of(context).textTheme.apply(
          bodyColor: const Color(0xff2F3825), //<-- SEE HERE
          displayColor: const Color(0xff2F3825), //<-- SEE HERE
        ),
        fontFamily: 'Prompt',
      ),
      home:  const SplashScreen()
      //
        // auth.currentUser == null ? LoginPage():HomePage()
    );
  }
}

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
         HomePage(),
          Cart(),
          OrderPage(),
          ProfilePage()
        ],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        border: const StadiumBorder(),
        items: const <BottomBarItem>[
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.shop,size: 18,),
            title: Text(' Shop',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff2C5E30),
          ),
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.bagShopping,size: 18,),
            title: Text('Cart',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff2C5E30),
          ),
          BottomBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            title: Text('My Order',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff2C5E30),
          ),
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.user,size: 18,),
            title: Text('My Profile',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff2C5E30),
          ),
        ],
      ),
    );
  }
}




