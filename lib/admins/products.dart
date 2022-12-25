
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/admins/addProducts.dart';
import 'package:groceryapp/widget/items.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'adminHome.dart';

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
  // items(){
  //    String net;
  //    String name;
  //    String img;
  //    String price;
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     alignment: Alignment.topLeft,
  //     children: [
  //       GestureDetector(
  //         onLongPress: (){
  //           showDialog<void>(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: const Text('Are you sure to Delete?',style: TextStyle(fontFamily: 'Prompt'),),
  //                 actions: <Widget>[
  //                   TextButton(
  //                     style: TextButton.styleFrom(
  //                       textStyle: Theme.of(context).textTheme.labelLarge,
  //                     ),
  //                     child: const Text('Delete',style: TextStyle(color: Colors.red,fontFamily: 'Prompt'),),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                   TextButton(
  //                     style: TextButton.styleFrom(
  //                       textStyle: Theme.of(context).textTheme.labelLarge,
  //                     ),
  //                     child: const Text('Cancel',style: TextStyle(fontFamily: 'Prompt'),),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15),
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.shade100,
  //                   spreadRadius: 2,
  //                   blurRadius: 7,
  //                   offset: Offset(0, 3), // changes position of shadow
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //
  //                 Container(
  //                   height: 180,
  //                   width:MediaQuery.of(context).size.width/1.2 ,
  //                   child: Image.asset(img,height: 180 ,fit: BoxFit.contain,),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     SizedBox(width: 5,),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                           color: Color(0xff2C5E30),
  //                           borderRadius: BorderRadius.circular(5)
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 6),
  //                         child: Text(net,style:
  //                         TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 15
  //                         )
  //                           ,),
  //                       ),
  //                     ),
  //                     SizedBox(width: 5,),
  //
  //                   ],
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 5.0,top:0),
  //                   child: Text(name,style:
  //                   TextStyle(
  //                       color: Color(0xff2F3825),
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w400,
  //                       fontFamily: 'Prompt'
  //                   )
  //                     ,),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 5.0,top: 0),
  //                   child: Text(price,style:
  //                   TextStyle(
  //                       color: Color(0xff2C5E30),
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                       fontFamily: 'Prompt'
  //                   )
  //                     ,),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3.0),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: Text("It is a long established fact that a reader will be distra by t"
  //                             "he readable  will be distracted by thunge is state controller established fact life",style: TextStyle(
  //                             fontWeight: FontWeight.normal,color: Colors.black38,fontFamily: 'Prompt'
  //                         ),),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 5,),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //     ],
  //   );
  // }
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
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Items(
                  net: data['net'],
                  name: data['name'],
                  img: data['downloadurl'],
                  price: data['price'],
                  description: data['description'],
                  symbol: data['symbol'],
                  id: document.id,
                  categories:data['categories'],

              );
            }).toList(),
          );
        },
      ),
    );
  }
}
