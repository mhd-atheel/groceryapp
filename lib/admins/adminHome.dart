import 'package:flutter/material.dart';
import 'package:groceryapp/loginpage.dart';

import '../widget/dashboardBox.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "DashBoard",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }, child: const Text("Logout",style: TextStyle(color: Colors.red),))
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20,),
              Functions.Dashboard_box(context,0xff3F9CBA,"Orders","07"),
              Functions.Dashboard_box(context,0xffEA40A6,"Users","10"),
              Functions.Dashboard_box(context,0xffF14B4B,"Products","03"),
              Functions.Dashboard_box(context,0xff519557,"Categories","\$1.5K"),
               const SizedBox(height: 20,),
            ],
          ),
        ),
    );
  }
}

