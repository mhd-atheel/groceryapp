import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/cart.dart';
import 'package:groceryapp/main.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/loading.dart';
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
  double newRating = 4;
  bool itemExist = false;
  bool isLoading = false;
  bool isAdd = false;
  // final Variable variable = Get.find();
  final ItemVariable c = Get.put(ItemVariable());
  TextEditingController reviewController = TextEditingController();
  @override
  void initState() {

    checkCart();
    super.initState();
  }
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Your review & rating")),
          insetPadding: const EdgeInsets.all(20),
          titlePadding: const EdgeInsets.only(top: 14.0, bottom: 4),

          //content: new Text("You are awesome!"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 300,
                width: 500,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 10),
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
                              controller: reviewController,
                              minLines: 2,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                hintText: 'Your review',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,

                              )),
                        ),
                      ),
                    ),

                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        newRating=rating;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    IsLoading.isLoading=true;
                                  });
                                  Map data={};
                                  await FirebaseFirestore.instance.collection('biodata').doc(Data.uuid).get().then((value) {
                                    data = value.data() as Map;
                                  }).then((value){
                                    FirebaseFirestore.instance.collection('reviews').doc().set({
                                      // 'name':data['name'],
                                      // 'downloadurl':data['downloadurl'],
                                      'author':FirebaseAuth.instance.currentUser!.uid,
                                      'review':reviewController.text,
                                      'rating':newRating,
                                      'date':Timestamp.now(),
                                      'productName':widget.data['name'],
                                    });
                                  }).then((value) {
                                    setState(() {
                                      print('success');
                                      IsLoading.isLoading=false;
                                      Navigator.pop(context);
                                    });
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      const Color(0xff27963c)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child:IsLoading.isLoading==false?const Text("Submit"):Loading(),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.black),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
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
          icon: const Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
        actions: [
          GestureDetector(
            child: const Icon(
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
            icon: const Icon(Icons.shopping_cart_outlined,size: 20,color: Color(0xff2C5E30),),
          ),
        ],
        // backgroundColor: Color(0xffF4F4F3),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff2C5E30),
        elevation: 0,
      ),
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text( widget.data['name'],style: const TextStyle(
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
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        child: Text('\$${ double.parse(widget.data['price'])*c.itemCount.value}',style:
                        const TextStyle(
                            color: Color(0xff2F3825),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt'
                        )
                          ,),
                      ),
                      Obx(()=> Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              if(c.itemCount<=1){
                                c.itemCount.value = 1;
                                print(c.itemCount.value);
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
                                c.itemCount.value--;
                                  print(c.itemCount.value);
                              }
                            },
                            child: const Icon(Icons.remove_circle_outline_rounded,size: 40,
                            ),
                          ),
                          const SizedBox(width: 6,),
                          Text("${c.itemCount.value}",style: const TextStyle(
                              fontSize: 25
                          ),),
                          const SizedBox(width: 6,),
                          GestureDetector(
                            onTap:(){
                              c.itemCount.value ++;
                                print(c.itemCount.value);

                            },
                            child: const Icon(Icons.add_circle_outline_rounded,size: 40,),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: const [
                      Text("Description",style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,top: 3.0,right: 16.0),
                  child: Row(
                    children: const [
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
                      const Text("Products Reviews",style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),),
                      TextButton(onPressed: (){
                        _showDialog(context);
                      }, child: const Text(
                        'Add Review'
                      ))
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('reviews').where('productName',isEqualTo: widget.data['name']).orderBy('date',descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final reviews = snapshot.data!.docs;
                    print(reviews);
                    return snapshot.data!.docs.isEmpty ?  const Center(child: Center(
                      child: Text('No Product Review',style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    )):ListView.builder(
                        itemCount: reviews.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection('biodata').doc(reviews[index]['author']).get(),
                            builder: (context, userSnapshot) {
                              if (!userSnapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                                child: ListTile(
                                  leading:ClipRRect(
                                    borderRadius: BorderRadius.circular(22), // Image border
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(22), // Image radius
                                      child:CachedNetworkImage(
                                        imageUrl: userData['downloadurl'],
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 80,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(userData['name'],style: const TextStyle(
                                          fontWeight: FontWeight.w600,fontFamily: 'Prompt',fontSize: 15
                                      ),),
                                      RatingBar.builder(
                                        initialRating:reviews[index]['rating'],
                                        minRating: 1,
                                        itemSize: 12,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(reviews[index]['review'],style: const TextStyle(
                                      fontWeight: FontWeight.normal,fontFamily: 'Prompt',fontSize: 10
                                  ),),
                                ),
                              );
                            },
                          );
                        }
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                  child: Row(
                    children: const [
                      Text("Related Products",style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                ),

                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: widget.data['categories']).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      height: 370,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> myData = document.data()! as Map<String, dynamic>;
                          return RelatedProductsContainer(
                            name: myData['name'],
                            downloadUrl: myData['downloadurl'],
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
                        'price': int.parse(widget.data['price'])*c.itemCount.value,
                        'quantity':c.itemCount.value
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


