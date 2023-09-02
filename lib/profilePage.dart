import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/editProfile.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:groceryapp/widget/profileContainer.dart';
import 'data.dart';


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
    super.initState();
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
        title:  const Text(
          "My Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: const Color(0xffF4F4F3),
        foregroundColor: const Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: (){
                      auth.signOut().then((value){
                        Get.offAll(const LoginPage());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const LoginPage()),
                        // );
                      });
                }, child: const Text("Logout",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
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
                    return const Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
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
                      color: const Color(0xff27963c),

                    ),
                    child: const Center(
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
