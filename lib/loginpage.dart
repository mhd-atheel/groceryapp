import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:groceryapp/admins/adminHome.dart';
import 'package:groceryapp/main.dart';
import 'package:groceryapp/signuppage.dart';
import 'package:groceryapp/validation/formValidation.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/loading.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'data.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final GlobalKey<FormState> _key = GlobalKey<FormState>();
   FirebaseAuth auth = FirebaseAuth.instance;
   String errorMessage = '';
   String? adminEmail = '';
   errorMsg(msg){
     MotionToast.error(
       title:  Text("System's Notification",style: TextStyle(fontWeight: FontWeight.bold)),
       description:  Text(msg),
       width:MediaQuery.of(context).size.width/1.2,
       position: MotionToastPosition.top,
       animationType:  AnimationType.fromTop,
     ).show(context);

   }
   String? validateEmail(String? formEmail) {
     if (formEmail == null || formEmail.isEmpty)
       return errorMsg("Email address is required ");
     String pattern = r'\w+@\w+\.\w+';
     RegExp regex = RegExp(pattern);
     if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
     return null;
   }
   String? validatePassword(String? formPassword) {
     if (formPassword == null || formPassword.isEmpty)
       return errorMsg('Password is required');
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
  void initState() {

    FirebaseFirestore.instance
        .collection('admin')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        adminEmail=doc["email"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text("Hi,Welcome back!",style: TextStyle(
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
                          Text("Hello again,you have been missed!",style: TextStyle(
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
                            validator:validateEmail,
                            controller: emailController,
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
                              validator:validatePassword,
                            controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: 'password ',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  )),
                        ),
                      ),
                    ),
                    GestureDetector(
                       onTap: () async{
                         if (_key.currentState!.validate()) {
                           setState(() {
                             IsLoading.isLoading=true;
                           });
                           try {
                               await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
                                 Data.uuid = FirebaseAuth.instance.currentUser!.uid;
                                 FirebaseFirestore.instance.collection('biodata').doc(Data.uuid).get().then((value) {
                                   if(value.exists) {
                                     String userType = value.data()!['userType'];
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
                                 }
                                 );
                                 setState(() {
                                   IsLoading.isLoading=false;
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
                            child:IsLoading.isLoading==false?Text("Login",style: TextStyle(
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
                          Text("Don't have an account?",style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 16,
                              color: Color(0xff2F3825)
                          ),),
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupPage()),
                            );
                          }, child:Text("Create Account",style: TextStyle(color: Color(0xff27963c)),) )
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




