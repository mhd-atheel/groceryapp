import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/editProfile.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:image_picker/image_picker.dart';

import 'data.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imageUrl = '';
  late String name = '';
  late String email= '';
  late String phone= '';
  late String address= '';
  @override
  void initState() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Data.uuid = FirebaseAuth.instance.currentUser!.uid;
  firestore.collection('biodata').doc(Data.uuid).get().then<dynamic>((DocumentSnapshot snapshot){
    Map myData = snapshot.data()as Map;
    print(myData);
    setState(() {
      name = myData['name'];
      email= myData['email'];
      phone= myData['phone'];
      address= myData['address'];
      imageUrl= myData['dowloadurl'];

    });
  });
  }


  FirebaseAuth auth  = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: (){
                      auth.signOut().then((value){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      });
                }, child: Text("Logout",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 200,
                  //   width: 200,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     // image: Image.network(imageUrl)
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: 10,),
              Center(
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none, // This is what you need.
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                              child: Text(
                                name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'Prompt'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        width: 123,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Color(0xff2C5E30),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Name',style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Prompt"
                            ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    //Container
                  ],
                  //<Widget>[]
                ),
              ),
              Center(
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none, // This is what you need.
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                              child: Text(
                                email.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'Prompt'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        width: 123,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Color(0xff2C5E30),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Email',style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Prompt"
                            ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    //Container
                  ],
                  //<Widget>[]
                ),
              ),
              Center(
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none, // This is what you need.
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                              child: Text(
                                address.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'Prompt'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        width: 123,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Color(0xff2C5E30),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Address',style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Prompt"
                            ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    //Container
                  ],
                  //<Widget>[]
                ),
              ),
              Center(
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none, // This is what you need.
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                              child: Text(
                                phone.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'Prompt'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        width: 123,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Color(0xff2C5E30),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            Text(
                              'Phone Number',style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Prompt"
                            ),
                            ),
                          ],
                        ),
                      ),
                    ), //Container
                    //Container
                  ],
                  //<Widget>[]
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const EditProfile()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0,left: 16,right: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffffa31a),

                    ),
                    child: Center(
                      child: Text("Edit Profile",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
