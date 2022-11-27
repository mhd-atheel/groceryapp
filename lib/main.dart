import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/cart.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/itemPage.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:groceryapp/orderpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xffF4F4F3),
        textTheme:
        Theme.of(context).textTheme.apply(
          bodyColor: Color(0xff2F3825), //<-- SEE HERE
          displayColor: Color(0xff2F3825), //<-- SEE HERE
        ),
        fontFamily: 'Prompt',



      ),
      home:  LoginPage(),
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
        children: [
         HomePage(),
          Cart(),
          OrderPage(),
          Container(color: Colors.orange),
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
        border: StadiumBorder(),
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.shop,size: 18,),
            title: Text(' Shop',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff2C5E30),
          ),
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping,size: 18,),
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
            title: Text('Account',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff2C5E30),
          ),
        ],
      ),
    );
  }
}




