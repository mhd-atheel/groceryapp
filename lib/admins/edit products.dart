import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class EditProducts extends StatefulWidget {
  final productId;
  final net;
  final name;
  final img;
  final price;
  final symbol;
  final description;
  final categories;
  const EditProducts({Key? key,
    required  this.productId,
    required  this.net,
    required  this.name,
    required  this.img,
    required  this.price,
    required  this.symbol,
    required  this.description,
    required  this.categories,
    }) : super(key: key);

  @override
  State<EditProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  String dropdownvalue = 'Vegetables';
  var items = [
    'Vegetables',
    'Fruits',
    'Meats',
    'SeaFoods',
    'Milk and Egg',
    'Breads',
    'Frozen',
    'Organic',
  ];

   int netIndex = 0;
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;
  final productController = TextEditingController();
  final priceController = TextEditingController();
  final netController = TextEditingController();
  final descriptionController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future ImagePickerMethod() async{
    final pick =await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null){
        _image = File(pick.path);
      }
      // else{
      //   showSnackBars("No File Selected", Duration(milliseconds: 400));
      // }
    });
  }
  @override
  void initState() {
    productController.text = widget.name;
    priceController.text = widget.price;
    netController.text = widget.net;
    descriptionController.text = widget.description;
    dropdownvalue = widget.categories;
    if(widget.symbol == 'gr'){
      setState(() {
        netIndex = 0;
      });
    }else{
      setState(() {
        netIndex = 1;
      });
    }
    // print(widget.productId);
    // print(widget.name);
    // print(widget.net);
    // print(widget.price);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Add New Products",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        ImagePickerMethod();
                      },
                      child: _image == null?CircleAvatar(
                        radius: 60,
                        child: Image.network(widget.img),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ):CircleAvatar(
                        radius: 40,
                        backgroundImage:FileImage(_image!),

                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text("Product Name ",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
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
                          controller: productController,
                          decoration: InputDecoration(
                            hintText: 'Product Name ',
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
                      Text("Price ",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
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
                          controller: priceController,
                          decoration: InputDecoration(
                            hintText: 'price ',
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
                      Text("Categories ",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
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
                            print(Value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text("Net ",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
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
                              controller: netController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '0.00gr',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            netIndex = 0;
                            print(netIndex);
                          });
                        },
                        child: Container(
                          height: 50,
                          width:MediaQuery.of(context).size.width/5,
                          decoration: BoxDecoration(
                              color: netIndex ==0 ?Color(0xff2C5E30):Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: netIndex ==0 ?Colors.white:Color(0xff2C5E30),
                                  width: 2
                              )
                          ),
                          child: Center(
                            child: Text("gr",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: netIndex ==0 ?Colors.white:Color(0xff2C5E30)
                            ),),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            netIndex = 1;
                            print(netIndex);
                          });
                        },
                        child: Container(
                          height: 50,
                          width:MediaQuery.of(context).size.width/5,
                          decoration: BoxDecoration(
                              color: netIndex ==1 ?Color(0xff2C5E30):Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: netIndex ==1 ?Colors.white:Color(0xff2C5E30),
                                  width: 2
                              )
                          ),
                          child: Center(
                            child: Text("kg",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: netIndex ==1 ?Colors.white:Color(0xff2C5E30)
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text("Description",style: TextStyle(
                          fontFamily: "Prompt",
                          fontSize: 15,
                          color: Color(0xff2F3825)
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      // 0xfff2f2f2  - like a gray
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: TextField(
                          controller: descriptionController,
                          minLines: 2,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Product Name ',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,

                          )),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    //final  posttime = DateTime.now().millisecondsSinceEpoch.toString();
                    if(_image!=null || widget.img ==null){
                      Reference ref = FirebaseStorage.instance.ref().child('ProductImage').child(productController.text);
                      await ref.putFile(_image!);
                      downloadURL = await ref.getDownloadURL();
                      FirebaseFirestore dataFire = FirebaseFirestore.instance;
                      await dataFire.collection("products").doc(widget.productId).update({
                        'name':productController.text,
                        'price':priceController.text,
                        'categories':dropdownvalue,
                        'net':netController.text,
                        'description':descriptionController.text,
                        'downloadurl':downloadURL,
                        'symbol': netIndex == 0 ? 'gr':'kg'
                      }).then((value){
                        print("Product Updated");
                        MotionToast.success(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 50,

                          title: const Text(
                            'System\'s Notification',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          description: Text('${widget.name} Product Updated Now!!',
                            style: TextStyle(fontSize: 12),
                          ),
                          layoutOrientation: ToastOrientation.ltr,
                          animationDuration: const Duration(milliseconds: 500),
                          position: MotionToastPosition.top,
                          animationType: AnimationType.fromTop,
                          dismissable: true,
                        ).show(context);
                      });
                    }
                    else{
                      FirebaseFirestore dataFire = FirebaseFirestore.instance;
                      await dataFire.collection("products").doc(widget.productId).update({
                        'name':productController.text,
                        'price':priceController.text,
                        'categories':dropdownvalue,
                        'net':netController.text,
                        'description':descriptionController.text,
                        'downloadurl':widget.img !=null ?widget.img: downloadURL,
                        'symbol': netIndex == 0 ? 'gr':'kg'
                      }).then((value){
                        print("Product Updated");
                        MotionToast.success(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 50,

                          title: const Text(
                            'System\'s Notification',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          description: Text('${widget.name} Product Updated Now!!',
                            style: TextStyle(fontSize: 12),
                          ),
                          layoutOrientation: ToastOrientation.ltr,
                          animationDuration: const Duration(milliseconds: 500),
                          position: MotionToastPosition.top,
                          animationType: AnimationType.fromTop,
                          dismissable: true,
                        ).show(context);
                      });
                    }




                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  const EditProfile()),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0,left: 16,right: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffffa31a),

                      ),
                      child: Center(
                        child: Text("Publish",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
