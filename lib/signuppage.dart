

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/loading.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'data.dart';
import 'data.dart';
import 'main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String address = 'your address';
  String phone = 'your number';
  String userType = 'user';
  String downloadURL = 'https://firebasestorage.googleapis.com/v0/b/grocery-app-9b16d.appspot.com/o/logo.png?alt=media&token=80b8001d-cdce-447a-a535-07b979bed2cf';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  errorMsg(msg){
    return MotionToast.error(
      title:  Text("System's Notification",style: TextStyle(fontWeight: FontWeight.bold)),
      description:  Text(msg),
      width:MediaQuery.of(context).size.width/1.2,
      position: MotionToastPosition.top,
      animationType:  AnimationType.fromTop,
    ).show(context);
  }
  String?  validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return errorMsg("Email address is required");
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
    return null;
  }
  String?   validateName(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return errorMsg("Name is required");
    }
    return null;
  }
  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return errorMsg('Password address is required');
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword))
      return errorMsg(
          "Password must be at least 8 characters, include an uppercase letter, number and symbol."
      ) ;
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 25,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text("Hi,Welcome guys!",style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 35,
                              color: Color(0xff2F3825),
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text("Hello again, we always with you!",style: TextStyle(
                              fontFamily: "Proppins",
                              fontSize: 15,
                              color: Color(0xff2F3825)
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(height: 40,),
                    Container(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
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
                          child: TextFormField(
                              controller: nameController,
                              validator: validateName,
                              decoration: InputDecoration(
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
                        children: [
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
                          child: TextFormField(
                            controller: emailController,
                              validator: validateEmail,
                              decoration: InputDecoration(
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
                        children: [
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
                          child: TextFormField(
                            controller: passwordController,
                              validator: validatePassword,
                              decoration: InputDecoration(
                                hintText: 'password ',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        if(_key.currentState!.validate()){
                          try{
                            setState(() {
                              IsLoading.isLoading=true;
                            });
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.createUserWithEmailAndPassword(
                                email: emailController.text, password: passwordController.text)
                                .then((value) async {
                              print("Signup Success Fully");
                              Data.uuid = FirebaseAuth.instance.currentUser!.uid;
                              FirebaseFirestore firestore = FirebaseFirestore.instance;
                              await  firestore.collection("biodata").doc(Data.uuid).set({
                                'name':nameController.text,
                                'email':emailController.text,
                                'password':passwordController.text,
                                'address':address,
                                'phone':phone,
                                'downloadurl': downloadURL,
                                'userType': userType,
                              }).then((value) {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const BottomNavbar()),
                                );
                                setState(() {
                                  IsLoading.isLoading=false;
                                });
                              });

                            });
                            errorMessage = '';
                          } on FirebaseAuthException catch (error) {
                            setState(() {
                              IsLoading.isLoading=false;
                            });
                            errorMessage = error.message!;
                          }
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 15,right: 15,top: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff27963c),

                          ),
                          child: Center(
                            child:IsLoading.isLoading==false? Text("Create Account",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),):Loading(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 16,
                              color: Color(0xff2F3825)
                          ),),
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          }, child:Text("Login",style: TextStyle(color: Color(0xff27963c),fontFamily: "Prompt"),) )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
