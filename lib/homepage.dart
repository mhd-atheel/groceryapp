import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groceryapp/variables.dart';
import 'package:groceryapp/widget/categoriesHome.dart';
import 'package:groceryapp/widget/productContainer.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name;
  String? searchValue;
  late String net;
  late String img = '';
  late String price;
  String productName = 'All';
  // int tabVale=1;
  final HomeVariable c = Get.put(HomeVariable());
  // late int isState;

  final List<String> images = [
   'assets/images/banner3.jpg',
   'assets/images/banner2.jpg',
   'assets/images/banner1.jpg',
  ];
  @override
  void initState() {
    c.isState.value=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  // SizedBox(width: 10,),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0,right: 10, top: 8,bottom: 8),
                      child: Container(

                        height: 45,
                        decoration: BoxDecoration(
                            color: const Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 0),
                          child: TextField(
                              onChanged: (val){
                                searchValue=val;
                              },
                              decoration:const  InputDecoration(
                                  labelText: 'Search Products ',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    size: 16,
                                    color: Colors.grey,
                                  ))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Icon(
                    FontAwesomeIcons.facebookMessenger,
                    size:40 ,
                    color: Color(0xff2C5E30),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children:const  [
                    Text(
                      "What do you looking for?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoriesHome(name: "Vegetables", img: 'assets/images/veg.png'),
                    CategoriesHome(name: "Fruits", img: 'assets/images/fruits.png'),
                    CategoriesHome(name: "Meats", img: 'assets/images/meat.png'),
                    CategoriesHome(name: "SeaFoods", img: 'assets/images/fish.png'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoriesHome(name: "Milk and Egg", img: 'assets/images/milk.png'),
                    CategoriesHome(name: "Breads", img: 'assets/images/bread.png'),
                    CategoriesHome(name: "Frozen", img: 'assets/images/frozen.png'),
                    CategoriesHome(name: "Organic", img: 'assets/images/organic.png'),

                  ],
                ),
              ),
              SizedBox(height:18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children:const  [
                    Text(
                      "Promotions for you?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 180.0,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                    itemCount:images.length,
                    options: CarouselOptions(
                      autoPlay: true,

                    ),
                    itemBuilder: (context, index, realIdx) {
                      return Container(
                        child: Center(
                            child: Image.asset(images[index],
                                fit: BoxFit.cover,)),
                      );
                    },
                  )),

              Obx(()=> Padding(
                  padding: const EdgeInsets.only(top: 16.0,left: 8,right: 8,bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSlidingSegmentedControl<int>(
                        initialValue: c.tabVale.value,
                        children: {
                          1: Text('All',style: TextStyle(color:c.tabVale.value==1?Colors.white:Color(0xff27963c)),),
                          2: Text('Vegetables',style: TextStyle(color:c.tabVale.value==2?Colors.white:Color(0xff27963c))),
                          3: Text('Fruits',style: TextStyle(color:c.tabVale.value==3?Colors.white:Color(0xff27963c))),
                          4: Text('Meats',style: TextStyle(color:c.tabVale.value==4?Colors.white:Color(0xff27963c))),
                        },
                        decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        thumbDecoration: BoxDecoration(
                          color: const Color(0xff27963c),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: const Offset(
                                0.0,
                                2.0,
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
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
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products for You",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                    Text(
                      c.productName.value,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              Obx(()=> StreamBuilder(
                  stream: c.isState.value==0?FirebaseFirestore.instance.collection('products').snapshots():FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: c.productName.value).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GridView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                           mainAxisSpacing: 10,
                        ),
                        primary: false,
                        // crossAxisSpacing: 10,
                        // mainAxisSpacing: 20,
                        // crossAxisCount: 2,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          data['id'] = document.id;
                          return ProductContainer(
                            data: data,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
