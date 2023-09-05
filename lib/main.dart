import 'package:bottom_bar/bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:groceryapp/cart.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/orderpage.dart';
import 'package:groceryapp/profilePage.dart';
import 'package:groceryapp/splashScreen.dart';

import 'loginpage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAsMVCStJSVBOLRRSpYUIiDorFnT8YziTk",
          appId: "1:700526240192:ios:9ce1307ed6105bdad52825",
          messagingSenderId: "700526240192",
          projectId: "grocery-app-9b16d"
      )
  );
  
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




