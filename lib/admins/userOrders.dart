

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../widget/userOrderWidget.dart';
import 'adminHome.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Orders",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor:const Color(0xffF4F4F3),
        foregroundColor:const Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').orderBy('orderedAt',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data!.docs;

          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context,index){
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('biodata').doc(orders[index]['userId']).get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                    return  UserOrderWidget(
                        name: userData['name'],
                        email: userData['email'],
                        image: userData['downloadurl'],
                        isExpand: orders[index]['isExpand'],
                        status: orders[index]['status'],
                        total: orders[index]['total'].toString(),
                        id:orders[index].id,
                      );
                  },
                );
              }
          );


        },
      ),
    );
  }
}
