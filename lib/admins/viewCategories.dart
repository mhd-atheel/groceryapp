import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/admins/categories.dart';
import 'package:groceryapp/widget/adminCategoriesContainer.dart';

class ViewCategories extends StatefulWidget {
  Map data;
   ViewCategories({Key? key, required Map<dynamic, dynamic> this.data, required String name}) : super(key: key);

  @override
  State<ViewCategories> createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          widget.data['name'],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Categories()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: widget.data['name']).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return AdminCategoriesContainer(
                  data: data,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
