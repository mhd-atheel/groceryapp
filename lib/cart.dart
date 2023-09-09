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
  bool isEmpty = false;
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Data.uuid = FirebaseAuth.instance.currentUser!.uid;
    firestore
        .collection('biodata')
        .doc(Data.uuid)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) {
      Map myData = snapshot.data() as Map;
      setState(() {
        addressController.text = myData['address'];
        name = myData['name'];
        email = myData['email'];
      });
    });
    getCart();
  }




  getCart() {
    c.totalPrice.value = 0;
    FirebaseFirestore.instance
        .collection('cart')
        .doc(Data.uuid)
        .collection('items')
        .get()
        .then((value) {
      for (var element in value.docs) {
        int price = element.data()['price'];
        int quantity = element.data()['quantity'];
        c.totalPrice.value = c.totalPrice.value + price * quantity;
      }
      setState(() {});
      print(c.totalPrice.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, fontFamily: "Poppins"),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .doc(Data.uuid)
                  .collection('items')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data()! as Map<String, dynamic>;
                          return CartWidget(
                            img: data['downloadurl'],
                            name: data['name'],
                            price: data['price'].toString(),
                            quantity: data['quantity'],
                            net: data['net'],
                            symbol: data['symbol'],
                          );
                        }),
                    snapshot.data!.docs.isEmpty
                        ? Container(
                            height:50,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8),
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                color: const Color(0xff27963c),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Cart is Empty',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ))
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Delivery Location",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          fontFamily: 'Prompt'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      // 0xfff2f2f2  - like a gray
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Colors.black54)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 0),
                                    child: TextField(
                                        controller: addressController,
                                        decoration: const InputDecoration(
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Delivery to",
                                      style: TextStyle(
                                          fontFamily: "Prompt",
                                          fontSize: 15,
                                          color: Color(0xff2F3825),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton(
                                      dropdownColor: Colors.white,
                                      underline: DropdownButtonHideUnderline(
                                          child: Container()),
                                      value: dropdownvalue,
                                      iconDisabledColor: Colors.transparent,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      isExpanded: true,
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownvalue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Order Info",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          fontFamily: 'Prompt'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Subtotal",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          fontFamily: 'Prompt'),
                                    ),
                                    Obx(() => Text(
                                          "\$${c.totalPrice.value}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                              fontFamily: 'Prompt'),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Delivery Cost",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          fontFamily: 'Prompt'),
                                    ),
                                    Text("\$0",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            fontFamily: 'Prompt')),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16),
                                child: Divider(
                                  color: Colors.black,
                                  height: 25,
                                  thickness: 1,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Totals",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          fontFamily: 'Prompt'),
                                    ),
                                    Obx(() => Text(
                                          "\$${c.totalPrice.value}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: 'Prompt'),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    snapshot.data!.docs.isEmpty
                        ? Container()
                        : GestureDetector(
                            onTap: () async {
                              int MAX = 10000000;
                              await FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc()
                                  .set({
                                'orderedAt': Timestamp.now(),
                                'deliveryAt': dropdownvalue,
                                'total': c.totalPrice.value,
                                'orderId': Random().nextInt(MAX),
                                'status': 'Waiting',
                                'isExpand': false,
                                'userId': Data.uuid,
                              }).then((value) async {
                                MotionToast.success(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 50,
                                  title: const Text(
                                    'System\'s Notification',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  description: const Text(
                                    'Checkout Successfully',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  layoutOrientation: ToastOrientation.ltr,
                                  animationDuration:
                                      const Duration(milliseconds: 1300),
                                  position: MotionToastPosition.top,
                                  animationType: AnimationType.fromTop,
                                  dismissable: true,
                                ).show(context);
                                await FirebaseFirestore.instance
                                    .collection("biodata")
                                    .doc(Data.uuid)
                                    .update({
                                  'address': addressController.text,
                                });
                                final WriteBatch batch =
                                    FirebaseFirestore.instance.batch();

                                await FirebaseFirestore.instance
                                    .collection("cart")
                                    .doc(Data.uuid)
                                    .collection("items")
                                    .get()
                                    .then((snap) async {
                                  for (var doc in snap.docs) {
                                    batch.delete(doc.reference);
                                  }
                                });
                                // execute the batch
                                await batch.commit().then((value) {
                                  print('Cart Item Deleted SuccessFully');

                                });
                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15.0,
                                      left: 16,
                                      right: 16,
                                      top: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xff27963c),
                                    ),
                                    child: Center(
                                      child: Obx(() => Text(
                                            "CHECKOUT (\$${c.totalPrice.value})",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
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
      ),
    );
  }
}
