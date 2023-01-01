

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/admins/adminHome.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/loginpage.dart';

import 'data.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      getUserInfo();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.home)),
    );
  }

  void getUserInfo() {
    if(FirebaseAuth.instance.currentUser!=null) {
      Data.uuid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection('biodata').doc(Data.uuid).get().then((value) {
        if(value.exists) {
          String userType = value.data()!['userType'];
          print(userType);
          if(userType=='admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  BottomNavbar()),
            );
          }
        }
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}