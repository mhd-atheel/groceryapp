import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/main.dart';
import 'package:groceryapp/signuppage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
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
                        child: TextField(
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
                        child: TextField(
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
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithEmailAndPassword(
                          email: emailController.text, password: passwordController.text).then((value) {
                             print(auth.currentUser?.uid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BottomNavbar()),
                            );
                      });


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
                          child: Text("Login",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),),
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
    );
  }
}