import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white
      ),
      home:  NavigationBar(),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
         HomePage(),
          Container(color: Colors.red),
          Container(color: Colors.greenAccent.shade700),
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
            activeColor: Color(0xff00e673),
          ),
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping,size: 18,),
            title: Text('Cart',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff00e673),
          ),
          BottomBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            title: Text('My Order',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff00e673),
          ),
          BottomBarItem(
            icon: Icon(FontAwesomeIcons.user,size: 18,),
            title: Text('Account',style: TextStyle(color: Colors.black54),),
            activeColor: Color(0xff00e673),
          ),
        ],
      ),
    );
  }
}




