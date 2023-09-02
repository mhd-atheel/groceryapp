import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:groceryapp/widget/orderContainer.dart';

import 'data.dart';
import 'main.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "My Order",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').where('userId',isEqualTo: Data.uuid).orderBy('orderedAt',descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.docs.isEmpty){
            return Center(child: Container(
                 height: 50,
                 width: MediaQuery.of(context).size.width/3,
                 decoration: BoxDecoration(
                    color:  Color(0xff27963c),
                   borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text('No More Orders',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  ),
                )));
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return OrderContainer(
                  orderId: data['orderId'].toString(),
                  deliveryAt: data['deliveryAt'],
                  total: data['total'].toString(),
                  date: data['orderedAt'],
                  status: data['status']);
            }).toList(),
          );
        },
      ),
    );
  }
}

