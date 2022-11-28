import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/loginpage.dart';

import 'data.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
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
    });
  });
  }
  late String name = '';
  late String email= '';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                  Center(
                    child: Container(
                      child: Column(
                        children: [
                          Text(name),
                          Text(email),
                          ElevatedButton(onPressed: (){
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((value){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                              print("logout ");
                            });
                          }, child: Text("Logout"))
                        ],
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}
