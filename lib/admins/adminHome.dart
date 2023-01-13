import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:groceryapp/variables.dart';

import '../widget/dashboardBox.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late int ordersCount = -1;
  late int userCount = -1;
  late int productCount = -1;
  AdminHomeVariable? p;
  //final AdminHomeVariable c = Get.put(AdminHomeVariable());
  @override
  void initState() {
    // c.orderCount.value;
    p = Get.find();
    print(p!.orderCount.value);
    // check();
    super.initState();
  }
  check() async {
    await FirebaseFirestore.instance.collection('orders').get(
    ).then((value) {
        p!.orderCount.value = value.size;
    });
    await FirebaseFirestore.instance.collection('biodata').get(
    ).then((value) {
        p!.userCount.value = value.size;
    });
    await FirebaseFirestore.instance.collection('products').get(
    ).then((value) {

        p!.productCount.value = value.size;
    });

  }
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
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            });
          }, child: const Text("Logout",style: TextStyle(color: Colors.red),))
        ],
      ),
        body: SingleChildScrollView(
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20,),
                Functions.Dashboard_box(context,0xff3F9CBA,"Orders",p!.orderCount.value),
                Functions.Dashboard_box(context,0xffEA40A6,"Users",p!.userCount.value),
                Functions.Dashboard_box(context,0xffF14B4B,"Products",p!.productCount.value),
                Functions.Dashboard_box(context,0xff519557,"Categories",p!.categoriesCount.value),
                 const SizedBox(height: 20,),
              ],
            ),
        ),
    );
  }
}

