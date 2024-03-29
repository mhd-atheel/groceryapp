

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../admins/edit products.dart';
import '../variables.dart';

class Items extends StatefulWidget {
  final String net;
  final String name;
  final String img;
  final String price;
  final String symbol;
  final String id;
  final String description;
  final String categories;
   Items({super.key,
    required this.net,
    required this.name,
    required this.img,
    required this.price,
    required this.description,
    required this.symbol,
    required this.id,
    required this.categories
  });

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  AdminHomeVariable _adminHomeVariable = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onTap: (){
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure to Delete?',style: TextStyle(fontFamily: 'Prompt'),),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.green,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Center(child: Text('Edit',style: TextStyle(fontFamily: 'Prompt',color: Colors.green,fontWeight: FontWeight.bold),)),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  EditProducts(
                                productId:widget.id,
                                net:widget.net,
                                name:widget.name,
                                img:widget.img,
                                price:widget.price,
                                symbol:widget.symbol,
                                description:widget.description,
                                categories:widget.categories,
                              )),
                            ).then((value) =>Navigator.of(context).pop());
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.red,
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Center(child: const Text('Delete',style: TextStyle(fontFamily: 'Prompt',color: Colors.red,fontWeight: FontWeight.bold))),
                          onPressed: () async{
                               FirebaseFirestore.instance.collection('products').doc(widget.id).delete().then((value) async {
                                 Navigator.of(context).pop();
                                 await FirebaseFirestore.instance.collection('products').get(
                                 ).then((value) {
                                   _adminHomeVariable.productCount.value = value.size;
                                   print(_adminHomeVariable.productCount.value);
                                 });
                                  MotionToast.warning(
                                   width: MediaQuery.of(context).size.width/1.2,
                                   height: 50,
                                   title: const Text(
                                     'System\'s Notification',
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                   description: const Text('Product Deleted Successfully',
                                     style: TextStyle(fontSize: 12),
                                   ),
                                   layoutOrientation: ToastOrientation.ltr,
                                   animationDuration: const Duration(milliseconds: 1300),
                                   position: MotionToastPosition.top,
                                   animationType: AnimationType.fromTop,
                                   dismissable: true,
                                 ).show(context);
                               }
                            );
                          },
                        ),
                      ),
                    ),
                    TextButton(
                     style: TextButton.styleFrom(
                       textStyle: Theme.of(context).textTheme.labelLarge,
                     ),
                     child: Center(child: const Text('Cancel',style: TextStyle(fontFamily: 'Prompt'),)),
                     onPressed: () {
                       Navigator.of(context).pop();
                     },
                      ),

                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
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
                  CachedNetworkImage(
                      imageUrl: widget.img,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                              ),
                        ),
                      ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5,),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff2C5E30),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 6),
                          child: Text(
                            '${widget.net}${widget.symbol}',style:
                          TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                          )
                            ,),
                        ),
                      ),
                      SizedBox(width: 5,),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,top:0),
                    child: Text(widget.name,style:
                    TextStyle(
                        color: Color(0xff2F3825),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prompt'
                    )
                      ,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,top: 0),
                    child: Text('\$'+widget.price,style:
                    TextStyle(
                        color: Color(0xff2C5E30),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt'
                    )
                      ,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("It is a long established fact that a reader will be distra by t"
                              "he readable  will be distracted by thunge is state controller established fact life",style: TextStyle(
                              fontWeight: FontWeight.normal,color: Colors.black38,fontFamily: 'Prompt'
                          ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
