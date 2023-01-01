import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/widget/items.dart';

import 'data.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: ElevatedButton(
                onPressed: () async {
                  FirebaseFirestore.instance
                      .collection('orders').
                      doc(Data.uuid).
                      collection('items')
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    for (var doc in querySnapshot.docs) {
                      print(doc['email']);
                      // print(doc['price']);
                      // print(doc['description']);
                      // print(doc['categories']);
                      // print(doc['net']);
                      // print(doc['downloadurl']);
                    }
                  });
                },
                child: Text("CLick"))),
        // StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('admin').snapshots(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(child: Text('Something went wrong'));
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     return ListView(
        //       shrinkWrap: true,
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;
        //         return ListTile(
        //           title:  Text(data['email']),
        //           subtitle:  Text(data['password']),
        //         );
        //       }).toList(),
        //     );
        //   },
        // )
      ],
    ));
  }
}
