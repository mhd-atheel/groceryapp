import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../data.dart';
import '../widget/loading.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  String dropdownvalue = 'Vegetables';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
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
  Future uploadImage() async {
    final  posttime = DateTime.now().millisecondsSinceEpoch.toString();
    Data.uuid = FirebaseAuth.instance.currentUser!.uid;
    Reference ref = FirebaseStorage.instance.ref().child(Data.uuid).child('userprofile').child(posttime);
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await  firestore.collection("products").doc().update({
      'downloadurl': downloadURL
    });
    print(downloadURL);
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
        child: Form(
          key: _key,
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
                          child: Image.asset("assets/images/logo.png"),
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
                        child: TextFormField(
                          controller: productController,
                            validator: validateName,
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
                        child: TextFormField(
                            controller: priceController,
                            validator: validatePrice,
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
                            child: TextFormField(
                              controller: netController,
                              validator: validateNet,
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
                        child: TextFormField(
                          controller: descriptionController,
                            validator: validateDescription,
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
                      setState(() {
                        IsLoading.isLoading=true;
                      });
                      if(_key.currentState!.validate()){
                        try{
                          if(_image!=null){
                            Reference ref = FirebaseStorage.instance.ref().child('ProductImage').child(productController.text);
                            await ref.putFile(_image!);
                            downloadURL = await ref.getDownloadURL();
                            FirebaseFirestore dataFire = FirebaseFirestore.instance;
                            await dataFire.collection("products").doc().set({
                              'name':productController.text,
                              'price':priceController.text,
                              'categories':dropdownvalue,
                              'net':netController.text,
                              'description':descriptionController.text,
                              'downloadurl': downloadURL,
                              'symbol': netIndex == 0 ? 'gr':'kg'
                            }).then((value){
                              setState(() {
                                IsLoading.isLoading =false;
                              });
                              print("Product Inserted");
                              MotionToast.success(
                                width: MediaQuery.of(context).size.width/1.2,
                                height: 50,

                                title: const Text(
                                  'System\'s Notification',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                description: const Text('New Product Published Now!!',
                                  style: TextStyle(fontSize: 12),
                                ),
                                layoutOrientation: ToastOrientation.ltr,
                                animationDuration: const Duration(milliseconds: 500),
                                position: MotionToastPosition.top,
                                animationType: AnimationType.fromTop,
                                dismissable: true,
                              ).show(context);
                            });
                          }else{
                            return MotionToast.error(
                              width: MediaQuery.of(context).size.width/1.2,
                              height: 50,

                              title: const Text(
                                'System\'s Notification',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              description: const Text('Please select image',
                                style: TextStyle(fontSize: 12),
                              ),
                              layoutOrientation: ToastOrientation.ltr,
                              animationDuration: const Duration(milliseconds: 500),
                              position: MotionToastPosition.top,
                              animationType: AnimationType.fromTop,
                              dismissable: true,
                            ).show(context);
                          }
                          errorMessage='';
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message!;
                        }
                        setState(() {});
                      }
                        //final  posttime = DateTime.now().millisecondsSinceEpoch.toString();





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
                          color: Color(0xff27963c),
                        ),
                        child: Center(
                          child:IsLoading.isLoading==false?Text("Publish",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),):Loading(),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

String?  validatePrice(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Price is required';
  return null;
}
String?   validateName(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Name is required';
  return null;
}
String?   validateNet(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Net is required';
  return null;
}
String?   validateDescription(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Description is required';
  return null;
}
