import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../variables.dart';
import '../widget/categoriesContainer.dart';
import '../widget/loading.dart';
import 'adminHome.dart';


class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late int fruitCount = -1;
  late int vegCount = -1;
  late int meatsCount = -1;
  late int seaCount = -1;
  late int milkCount = -1;
  late int breadCount = -1;
  late int frozenCount = -1;
  late int organicCount = -1;
  @override
  void initState() {
    check();
    print('Helo');
    super.initState();
  }
  check() async {
    setState(() {
      IsLoading.isLoading=true;
    });
    await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Fruits').get(
    ).then((value) {
      setState(() {
        fruitCount = value.size;
        print(fruitCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Vegetables').get(
    ).then((value) {
      setState(() {
        vegCount = value.size;
        print(vegCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Meats').get(
    ).then((value) {
      setState(() {
        meatsCount = value.size;
        print(meatsCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'SeaFoods').get(
    ).then((value) {
      setState(() {
        seaCount = value.size;
        print(seaCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Milk and Egg').get(
    ).then((value) {
      setState(() {
        milkCount = value.size;
        print(milkCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Breads').get(
    ).then((value) {
      setState(() {
        breadCount = value.size;
        print(breadCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Frozen').get(
    ).then((value) {
      setState(() {
        frozenCount = value.size;
        print(frozenCount);
      });
    });await FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: 'Organic').get(
    ).then((value) {
      setState(() {
        organicCount = value.size;
        print(organicCount);
      });
    });
    setState(() {
      IsLoading.isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Categories",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
      ),
      body: Column(
        children: [
          CategoriesContainer(
            img: 'assets/images/fruits.png',
            name: 'Fruits',
            quantity:IsLoading.isLoading==false?
          fruitCount<=9&&fruitCount>=0?'0'+fruitCount.toString():fruitCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/veg.png',
            name: 'Vegetables',
            quantity:IsLoading.isLoading==false? vegCount<=9&&vegCount>=0?'0'+vegCount.toString():vegCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/meat.png',
            name: 'Meats',
            quantity: IsLoading.isLoading==false? meatsCount<=9&&meatsCount>=0?'0'+meatsCount.toString():meatsCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/fish.png',
            name: 'SeaFoods',
            quantity: IsLoading.isLoading==false? seaCount<=9&&seaCount>=0?'0'+seaCount.toString():seaCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/milk.png',
            name: 'Milk and Egg',
            quantity:IsLoading.isLoading==false? milkCount<=9&&milkCount>=0?'0'+milkCount.toString():milkCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/bread.png',
            name: 'Breads',
            quantity:IsLoading.isLoading==false? breadCount<=9&&breadCount>=0?'0'+breadCount.toString():breadCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/frozen.png',
            name: 'Frozen',
            quantity:IsLoading.isLoading==false?  frozenCount<=9&&frozenCount>=0?'0'+frozenCount.toString():frozenCount.toString():'...',
          ),
          CategoriesContainer(
            img: 'assets/images/organic.png',
            name: 'Organic',
            quantity: IsLoading.isLoading==false? organicCount<=9&&organicCount>=0?'0'+organicCount.toString():organicCount.toString():'...',
          ),

        ],
      ),
    );
  }
}
