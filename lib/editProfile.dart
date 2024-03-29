import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/profilePage.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String currentPassword = '';
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

    showLoadingIndicator() {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return const CircularProgressIndicator();
       },
     );
   }
   Future imagePickerMethod() async{
    final pick =await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null){
        _image = File(pick.path);
      }
      // else{
      //   showSnackBars("No File Selected", Duration(milliseconds: 400));
      // }
    });
  }
  Future uploadImage() async {
    final  postTime = DateTime.now().millisecondsSinceEpoch.toString();
    Data.uuid = FirebaseAuth.instance.currentUser!.uid;
    Reference ref = FirebaseStorage.instance.ref().child('UserProfiles').child(Data.uuid).child(postTime);
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    await  fireStore.collection("biodata").doc(Data.uuid).update({
      'downloadurl': downloadURL
    });
    print(downloadURL);
  }

  @override
  void initState() {
    super.initState();
      setState(() {
        IsLoading.isLoading=false;
      });
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    Data.uuid = FirebaseAuth.instance.currentUser!.uid;
    fireStore.collection('biodata').doc(Data.uuid).get().then<dynamic>((DocumentSnapshot snapshot){
      Map myData = snapshot.data()as Map;
      print(myData);
      setState(() {
        nameController.text = myData['name'];
        emailController.text= myData['email'];
        passwordController.text= myData['password'];
        currentPassword= myData['password'];
        addressController.text= myData['address'];
        phoneController.text= myData['phone'];
        downloadURL= myData['downloadurl'];

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          "Edit Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: const Color(0xffF4F4F3),
        foregroundColor: const Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        imagePickerMethod();
                      },
                      child: _image == null?CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: Image.network(downloadURL!),
                      ):CircleAvatar(
                        radius: 40,
                        backgroundImage:FileImage(_image!),

                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: const [
                      Text("Your Name",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      // 0xfff2f2f2  - like a gray
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'your name',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: const[
                      Text("Email Address",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      // 0xfff2f2f2  - like a gray
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: TextField(
                          enableInteractiveSelection: false,
                          enabled: false,
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'example@gmail.com ',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children:const [
                      Text("Password",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: TextField(
                          controller: passwordController,
                          enabled: false,
                          obscureText: true,
                          decoration:const InputDecoration(
                            hintText: 'password ',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children:const [
                      Text("Phone Number",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: TextField(
                          controller: phoneController,
                          decoration:const InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children:const [
                      Text("Address",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: TextField(
                          controller: addressController,
                          decoration:const InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const ProfilePage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 0,right: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.2,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(color:const Color(0xff27963c) )

                          ),
                          child:const Center(
                            child: Text("CENCEL",style: TextStyle(
                                color: Color(0xff27963c),
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () async{
                        setState(() {
                          IsLoading.isLoading=true;
                        });
                        if(_image!=null || downloadURL==null){
                          final  postTime = DateTime.now().millisecondsSinceEpoch.toString();
                          Data.uuid = FirebaseAuth.instance.currentUser!.uid;
                          Reference ref = FirebaseStorage.instance.ref().child('UserProfiles').child(Data.uuid).child(postTime);
                          await ref.putFile(_image!);
                          downloadURL = await ref.getDownloadURL();
                          Data.uuid = FirebaseAuth.instance.currentUser!.uid;
                          FirebaseFirestore firestore = FirebaseFirestore.instance;
                          await  firestore.collection("biodata").doc(Data.uuid).update({
                            'name':nameController.text,
                            'email':emailController.text,
                            'address':addressController.text,
                            'phone':phoneController.text,
                            'downloadurl': downloadURL
                          }).then((value) {

                            setState(() {
                              IsLoading.isLoading =false;

                            });
                            MotionToast.success(
                              width: MediaQuery.of(context).size.width/1.2,
                              height: 50,

                              title: const Text(
                                'System\'s Notification',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              description: const Text('Uploaded Successfully',
                                style: TextStyle(fontSize: 12),
                              ),
                              layoutOrientation: ToastOrientation.ltr,
                              animationDuration: const Duration(milliseconds: 1300),
                              position: MotionToastPosition.top,
                              animationType: AnimationType.fromTop,
                              dismissable: true,
                            ).show(context);
                          });
                        }else{
                          Data.uuid = FirebaseAuth.instance.currentUser!.uid;
                          FirebaseFirestore fireStore = FirebaseFirestore.instance;
                          await  fireStore.collection("biodata").doc(Data.uuid).update({
                            'name':nameController.text,
                            'email':emailController.text,
                            // 'password':passwordController.text,
                            'address':addressController.text,
                            'phone':phoneController.text,
                            'downloadurl': downloadURL
                          }).then((value) {
                            setState(() {
                              IsLoading.isLoading =false;
                            });
                            MotionToast.success(
                              width: MediaQuery.of(context).size.width/1.2,
                              height: 50,
                              title: const Text(
                                'System\'s Notification',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              description: const Text('Uploaded Successfully',
                                style: TextStyle(fontSize: 12),
                              ),
                              layoutOrientation: ToastOrientation.ltr,
                              animationDuration: const Duration(milliseconds: 1300),
                              position: MotionToastPosition.top,
                              animationType: AnimationType.fromTop,
                              dismissable: true,
                            ).show(context);
                          });
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 0,right: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.2,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:const Color(0xff27963c),

                          ),
                          child: Center(
                            child:IsLoading.isLoading==false?const Text("SAVE",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),):Loading()
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            )
          ]
        ),
      )
    );
  }
}
