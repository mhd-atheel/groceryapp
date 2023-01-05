import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/cart.dart';
import 'package:groceryapp/main.dart';
import 'package:groceryapp/widget/relatedProductsContainer.dart';
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
  bool isAdd = false;
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
                        child: Text('\$${ double.parse(widget.data['price'])*counter}',style:
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
                  padding: const EdgeInsets.only(left: 16.0,top: 3.0,right: 16.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Products Reviews",style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),),
                      TextButton(onPressed: (){
                        _showDialog(context);
                      }, child: Text(
                        'Add Review'
                      ))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                  child: ListTile(

                    leading: CircleAvatar(child: Image.asset('assets/images/logo.png')),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Aathil Mohamed",style: TextStyle(
                            fontWeight: FontWeight.w600,fontFamily: 'Prompt',fontSize: 15
                        ),),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          itemSize: 12,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                    subtitle: Expanded(
                      child: Text("It is a long established fact that a reader will be distra byact that a reader will be distra by t"
                          "he readable  will be distracted by thunge is state controller established  t"
                          "he readable  will be distracted by thunge is state controller established fact life",style: TextStyle(
                          fontWeight: FontWeight.normal,fontFamily: 'Prompt',fontSize: 10
                      ),),
                    ),
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

                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: widget.data['categories']).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      height: 370,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return RelatedProductsContainer(
                            name: data['name'],
                            downloadUrl: data['downloadurl'],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 70,),
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
                        'name': widget.data['name'],
                        'downloadurl': widget.data['downloadurl'],
                        'net': widget.data['net'],
                        'symbol': widget.data['symbol'],
                        'price': int.parse(widget.data['price'])*counter,
                        'quantity':counter
                      }
                  ).then((value) {
                    setState(() {
                      isAdd = true;
                    });
                  });
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
                        child: Text( itemExist ? "Already added to cart":isAdd?'Added':"ADD TO CART",style: TextStyle(
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
_showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: new Text("Add Deparment")),
        insetPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.only(top: 14.0, bottom: 4),

        //content: new Text("You are awesome!"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 200,
              width: 500,
              color: Colors.white,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.deepPurpleAccent)),
                      hintText: 'Add Department',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.black),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Submit"),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.white),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.black),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Cancel"),
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}

