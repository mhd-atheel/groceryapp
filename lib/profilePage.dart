import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:groceryapp/widget/items.dart';
import 'package:groceryapp/widget/profileContainer.dart';
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
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('biodata').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ProfileContainer(
                    imageUrl: snapshot.data!['downloadurl'],
                    name: snapshot.data!['name'],
                    phone: snapshot.data!['phone'],
                    address: snapshot.data!['address'],
                    email: snapshot.data!['email'],
                  );
                },
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
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff27963c),

                    ),
                    child: Center(
                      child: Text("EDIT PROFILE",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
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
