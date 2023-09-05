

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryapp/admins/adminHome.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:groceryapp/variables.dart';

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
    Future.delayed(const Duration(seconds: 3)).then((value) {

      getUserInfo();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
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
              MaterialPageRoute(builder: (context) =>  const BottomNavbar()),
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



