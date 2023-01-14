import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:groceryapp/admins/addProducts.dart';
import 'package:groceryapp/widget/items.dart';

import '../variables.dart';
import 'adminHome.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  HomeVariable c = Get.put(HomeVariable());
  @override
  void initState() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('products').doc().get().then<dynamic>((DocumentSnapshot snapshot){
      Map myData = snapshot.data()as Map;
      setState(() {
        print(myData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProducts()),
            );
          },
          //0xffffa31a like a orange color-this color used to old button color
          backgroundColor:Color(0xff27963c),
          child: const FaIcon(FontAwesomeIcons.plus)
      ),
      appBar: AppBar(
        title:  Text(
          "Products",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(()=> Padding(
      padding: const EdgeInsets.only(top: 16.0,left: 8,right: 8,bottom: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20,),
            CustomSlidingSegmentedControl<int>(
              initialValue: c.tabVale.value,
              children: {
                1: Text('All',style: TextStyle(color:c.tabVale.value==1?Colors.white:Color(0xff27963c)),),
                2: Text('Vegetables',style: TextStyle(color:c.tabVale.value==2?Colors.white:Color(0xff27963c))),
                3: Text('Fruits',style: TextStyle(color:c.tabVale.value==3?Colors.white:Color(0xff27963c))),
                4: Text('Meats',style: TextStyle(color:c.tabVale.value==4?Colors.white:Color(0xff27963c))),
                5: Text('SeaFoods',style: TextStyle(color:c.tabVale.value==5?Colors.white:Color(0xff27963c))),
                6: Text('Breads',style: TextStyle(color:c.tabVale.value==6?Colors.white:Color(0xff27963c))),
              },
              decoration: BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: Color(0xff27963c),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  ),
                ],
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                c.tabVale.value=v;
                print(c.tabVale.value);
                print(v);
                if(c.tabVale.value==1){
                  c.productName.value= 'All';
                  c.isState.value = 0;
                }
                if(c.tabVale.value==2){
                  c.isState.value = 1;
                  c.productName.value= 'Vegetables';
                }
                if(c.tabVale.value==3){
                  c.isState.value = 1;
                  c.productName.value= 'Fruits';

                }
                if(c.tabVale.value==4){
                  c.isState.value = 1;
                  c.productName.value= 'Meats';
                }
                if(c.tabVale.value==5){
                  c.isState.value = 1;
                  c.productName.value= 'SeaFoods';
                }
                if(c.tabVale.value==6){
                  c.isState.value = 1;
                  c.productName.value= 'Breads';
                }
              },
            ),
          ],
        ),
      ),
    ),),
            Obx(
           ()=> StreamBuilder(
                  stream:c.isState.value == 0? FirebaseFirestore.instance.collection('products').snapshots():FirebaseFirestore.instance.collection('products').where('categories',isEqualTo:c.productName.value).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Items(
                          net: data['net'],
                          name: data['name'],
                          img: data['downloadurl'],
                          price: data['price'],
                          description: data['description'],
                          symbol: data['symbol'],
                          id: document.id,
                          categories:data['categories'],

                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
