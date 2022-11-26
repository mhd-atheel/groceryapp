

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/cartWidget.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int val = 10;
  int counter = 0;

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
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Row(
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             "Cart",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 25,
              //                 fontFamily: "Poppins"),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            CartWidget(
              name: "Banana",
              img: "assets/images/strawberry.png",
              price: "\$20",
            ),
            CartWidget(
              name: "Orange",
              img: "assets/images/orange.png",
              price: "\$15",
            ),
              CartWidget(
                name: "Banana",
                img: "assets/images/banana.png",
                price: "\$15",
              ),
              CartWidget(
                name: "Spinach",
                img: "assets/images/spinach.png",
                price: "\$15",
              ),


             // cartContainer('assets/images/spinach.png',"Spinach","\$0.14"),
             // cartContainer('assets/images/strawberry.png',"Strawberry","\$0.14"),
             // cartContainer('assets/images/orange.png',"Orange","\$0.14"),
             // cartContainer('assets/images/greenapple.png',"Green Apple","\$0.14"),
             // cartContainer('assets/images/banana.png',"Banana","\$0.14"),

            ],
          ),
        ),
      ),
    );
  }
}
