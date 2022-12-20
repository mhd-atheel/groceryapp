import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/cart.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/main.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'data.dart';
class ItemPage extends StatefulWidget {
  final Map data;

   ItemPage({Key? key, required this.data}) : super(key: key);
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int counter = 1;
  bool itemExist = false;
  bool isLoading = false;
  @override
  void initState() {
    checkCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavbar()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
        actions: [
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.heart,size: 20,color: Color(0xff2C5E30),
            ),
            onTap:() {
              print("Heart Icons");
            },
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined,size: 20,color: Color(0xff2C5E30),),
          ),
        ],
        // backgroundColor: Color(0xffF4F4F3),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff2C5E30),
        elevation: 0,
      ),
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text( widget.data['name'],style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt'
                ),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/4.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.shade100,
                      //     spreadRadius: 2,
                      //     blurRadius: 7,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl:  widget.data['downloadurl'],
                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height/3.5,
                        width:  MediaQuery.of(context).size.width,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0,top: 0),
                        child: Text('\$${ widget.data['price']}',style:
                        TextStyle(
                            color: Color(0xff2F3825),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt'
                        )
                          ,),
                      ),
                      Row(

                        children: [
                          GestureDetector(
                            onTap:(){
                              if(counter<=1){
                                counter = 1;
                                print(counter);
                                MotionToast.warning(
                                  width: MediaQuery.of(context).size.width/1.2,
                                  height: 50,

                                  title: const Text(
                                    'System\'s Alert',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  description: const Text('A minimum of 01 item is required',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  layoutOrientation: ToastOrientation.ltr,
                                  animationDuration: const Duration(milliseconds: 500),
                                  position: MotionToastPosition.top,
                                  animationType: AnimationType.fromTop,
                                  dismissable: true,
                                ).show(context);
                              }
                              else{
                                setState(() {
                                  counter--;
                                  print(counter);
                                });
                              }

                            },
                            child: Icon(Icons.remove_circle_outline_rounded,size: 40,
                            ),
                          ),
                          SizedBox(width: 6,),
                          Text("$counter",style: TextStyle(
                            fontSize: 25
                          ),),
                          SizedBox(width: 6,),
                          GestureDetector(
                            onTap:(){
                              setState(() {
                                counter ++;
                                print(counter);

                              });
                            },
                            child: Icon(Icons.add_circle_outline_rounded,size: 40,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text("Description",style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                  child: Row(
                    children: [
                      Text("Realated Products",style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topLeft,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BottomNavbar()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffEEF2F9),
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

                                    Container(
                                      height: 100,
                                      width: 110,
                                      child: Image.asset('assets/images/broc.png',height: 120 ,fit: BoxFit.contain,),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 5,),

                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0,top:0),
                                      child: Text('Orange',style:
                                      TextStyle(
                                          color: Color(0xff2F3825),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Prompt'
                                      )
                                        ,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topLeft,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BottomNavbar()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffEEF2F9),
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

                                    Container(
                                      height: 100,
                                      width: 110,
                                      child: Image.asset('assets/images/orange.png',height: 120 ,fit: BoxFit.contain,),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 5,),

                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0,top:0),
                                      child: Text('Orange',style:
                                      TextStyle(
                                          color: Color(0xff2F3825),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Prompt'
                                      )
                                        ,),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topLeft,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BottomNavbar()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffEEF2F9),
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

                                    Container(
                                      height: 100,
                                      width: 110,
                                      child: Image.asset('assets/images/spinach.png',height: 120 ,fit: BoxFit.contain,),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 5,),

                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0,top:0),
                                      child: Text('Orange',style:
                                      TextStyle(
                                          color: Color(0xff2F3825),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Prompt'
                                      )
                                        ,),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70,)
              ],
            ),
          ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                if(!itemExist && !isLoading) {
                  await FirebaseFirestore.instance.collection("cart").doc(
                      Data.uuid).collection('items')
                      .doc(widget.data['id'])
                      .set(
                      {
                        'name': widget.data['name']
                      }
                  );
                } else {

                }
                },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 16,right: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff27963c),

                      ),
                      child: !isLoading ? Center(
                        child: Text( itemExist ? "Already added to cart": "ADD TO CART",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),),
                      ):Center(child: CircularProgressIndicator(color: Colors.white,)),
                    ),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Future<void> checkCart() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection("cart").doc(Data.uuid).collection('items').doc(widget.data['id']).get().then((value) async {
      if(value.exists){
        setState(() {
          itemExist = true;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
