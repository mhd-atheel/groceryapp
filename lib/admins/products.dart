import 'dart:html';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/admins/addProducts.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('products').doc().get().then<dynamic>((DocumentSnapshot snapshot){
      Map myData = snapshot.data()as Map;
      setState(() {
        print(myData);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProducts()),
            );
          },
          backgroundColor:Color(0xffffa31a),
          child: const FaIcon(FontAwesomeIcons.plus)
      ),
      appBar: AppBar(
        title:  Text(
          "Products",
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
      body: Column(
        children: [

        ],
      ),
    );
  }
}
