import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 5),
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height:10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffffebcc),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                              child: Text(
                                "Waiting for Payment",
                                style: TextStyle(
                                  color: Color(0xffffcc80),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("2022/11/24",
                          style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0,top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Transaction ID",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("#8485143",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Delivary to",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("At Home",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Total Payment",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("\$200",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height:10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffcce6ff),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                              child: Text(
                                "On Process",
                                style: TextStyle(
                                  color: Color(0xff66a3ff),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("2022/11/24",
                          style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0,top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Transaction ID",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("#8485143",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Delivary to",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("At Home",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Total Payment",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("\$200",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16,top: 5),
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height:10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffffcce0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                              child: Text(
                                "Failed",
                                style: TextStyle(
                                    color: Color(0xffff8080),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("2022/11/24",
                          style: TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0,top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Transaction ID",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("#8485143",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Delivary to",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("At Home",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Total Payment",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("\$200",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

