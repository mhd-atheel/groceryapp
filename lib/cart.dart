

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/cartWidget.dart';

import 'data.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int val = 10;
  int counter = 0;
  String dropdownvalue = 'At Home';
  var items = [
    'At Home',
    'At Office',
      ];
  final addressController = TextEditingController();
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Data.uuid = FirebaseAuth.instance.currentUser!.uid;
    firestore.collection('biodata').doc(Data.uuid).get().then<dynamic>((DocumentSnapshot snapshot){
      Map myData = snapshot.data() as Map;
      setState(() {
        addressController.text= myData['address'];
      });
    });

  }

  cartContainer(img,name, price){
     int counter = 0;

     return  Container(
        height: 120,

        child: Row(
          children: [
            Container(
              height: 120,
              width: 130,
              child: Image.asset(
                img,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:20),
                Text(
                 name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Poppins"),
                ),
                SizedBox(height:5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "2.00kg",
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "2.20kg",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                SizedBox(height:5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                      style: TextStyle(
                        color: Color(0xff00be5e),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 120,),
                    Row(

                      children: [
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              counter--;

                            });
                          },
                          child: Icon(FontAwesomeIcons.minus,size: 15,
                          ),
                        ),
                        SizedBox(width: 3,),
                        Text("$counter"),
                        SizedBox(width: 3,),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              counter ++;
                              print(counter);
                            });
                          },
                          child: Icon(FontAwesomeIcons.plus,size: 15,),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            )
          ],
        ),
      );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Cart",
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CartWidget(
                name: "Banana",
                img: "assets/images/strawberry.png",
                price: "20",
          ),
                CartWidget(
                name: "Orange",
                img: "assets/images/orange.png",
                price: "15",
          ),
                CartWidget(
                  name: "Banana",
                  img: "assets/images/banana.png",
                  price: "15",
                ),
                CartWidget(
                  name: "Spinach",
                  img: "assets/images/spinach.png",
                  price: "15",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "Delivery Location",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                      ),
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
                          controller: addressController,
                          decoration: InputDecoration(
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
                      Text("Delivery to",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825),
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    height: 50,
                    width:MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        underline: DropdownButtonHideUnderline(child: Container()),
                        value: dropdownvalue,
                        iconDisabledColor: Colors.transparent,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),

                          );
                        }).toList(),
                        onChanged: (String? Value) {
                          setState(() {
                            dropdownvalue = Value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "Order Info",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                      ),
                    ],
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                      Text(
                        "\$200",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Cost",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                      Text(
                        "\$0",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 16),
                  child: Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Totals",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                      Text(
                        "\$200",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            GestureDetector(
              onTap: () async {

              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0,left: 16,right: 16,top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff27963c),

                      ),
                      child: Center(
                        child: Text("CHECKOUT (\$200)",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
