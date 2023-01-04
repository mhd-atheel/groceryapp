

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/cartWidget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
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
  final Variable c = Get.put(Variable());
  late final String name;
  late final String email;
  bool isEmpty =false;
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Data.uuid = FirebaseAuth.instance.currentUser!.uid;
    firestore.collection('biodata').doc(Data.uuid).get().then<dynamic>((DocumentSnapshot snapshot){
      Map myData = snapshot.data() as Map;
      setState(() {
        addressController.text= myData['address'];
        name= myData['name'];
        email= myData['email'];
      });
    });
    getCart();
  }
  void showAlert(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () async {

        int MAX = 10000000;
        await FirebaseFirestore.instance.collection('orders').doc().set({
          'orderedAt': Timestamp.now(),
          'deliveryAt':dropdownvalue,
          'total':c.totalPrice.value,
          'orderId':new Random().nextInt(MAX),
          'status':'Waiting',
          'name':name,
          'email':email,
          'isExpand':false,
          'userId':Data.uuid,
        }).then((value){
          MotionToast.success(
            width: MediaQuery.of(context).size.width/1.2,
            height: 50,
            title: const Text(
              'System\'s Notification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            description: const Text('Checkout Successfully',
              style: TextStyle(fontSize: 12),
            ),
            layoutOrientation: ToastOrientation.ltr,
            animationDuration: const Duration(milliseconds: 1300),
            position: MotionToastPosition.top,
            animationType: AnimationType.fromTop,
            dismissable: true,
          ).show(context);
        });
        await FirebaseFirestore.instance.collection("biodata").doc(Data.uuid).update({
          'address':addressController.text,
        }).then((value) {
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void startOneTimePayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1221820", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "5.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": 30.00,
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("One Time Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("One Time Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  getCart(){
    c.totalPrice.value = 0;
    FirebaseFirestore.instance.collection('cart').doc(Data.uuid).collection('items').get().then((value) {
      for (var element in value.docs) {
        int price = element.data()['price'];
        int quantity = element.data()['quantity'];
        c.totalPrice.value = c.totalPrice.value + price * quantity;
      }
      setState(() {

      });
      print(c.totalPrice.value);
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('cart').doc(Data.uuid).collection('items').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        // ListView(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        //     print(data['price']);
                        //     return CartWidget(
                        //         img: data['downloadurl'],
                        //         name:data['name'],
                        //         price: data['price'].toString(),
                        //         quantity:data['quantity'],
                        //         net: data['net'],
                        //         symbol:data['symbol'],
                        //       changeState: setState,
                        //     );
                        //
                        //   }).toList(),
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                              return CartWidget(
                            img: data['downloadurl'],
                            name:data['name'],
                            price: data['price'].toString(),
                            quantity:data['quantity'],
                            net: data['net'],
                            symbol:data['symbol'],
                          );
                        }),
                        snapshot.data!.docs.isEmpty ?Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                                color:  Color(0xff27963c),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text('Cart is Empty',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              ),
                            )):Column(
                          children: [
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
                                  Obx(() => Text(
                                    "\$${c.totalPrice.value}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        fontFamily: 'Prompt'
                                    ),
                                  ))
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
                                  ),Text(
                                      "\$0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          fontFamily: 'Prompt'
                                      ))
                                  ,
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
                                  Obx(() => Text(
                                    "\$${c.totalPrice.value}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'Prompt'
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        snapshot.data!.docs.isEmpty ?Container():GestureDetector(
                          onTap: () async {
                            startOneTimePayment(context);
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
                                    child: Obx(() => Text("CHECKOUT (\$${c.totalPrice.value})",style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),)) ,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),


              ],
            ),



          ],
        ),
      ),
    );
  }
}
