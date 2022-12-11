import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widget/categoriesContainer.dart';
import 'adminHome.dart';


class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
            quantity: '12',
          ),
          CategoriesContainer(
            img: 'assets/images/veg.png',
            name: 'Vegetables',
            quantity: '10',
          ),
          CategoriesContainer(
            img: 'assets/images/meat.png',
            name: 'Meats',
            quantity: '04',
          ),
          CategoriesContainer(
            img: 'assets/images/fish.png',
            name: 'Sea Foods',
            quantity: '07',
          ),
          CategoriesContainer(
            img: 'assets/images/milk.png',
            name: 'Milk and Egg',
            quantity: '04',
          ),
          CategoriesContainer(
            img: 'assets/images/bread.png',
            name: 'Breads',
            quantity: '05',
          ),
          CategoriesContainer(
            img: 'assets/images/frozen.png',
            name: 'Frozen',
            quantity: '06',
          ),
          CategoriesContainer(
            img: 'assets/images/organic.png',
            name: 'Organic',
            quantity: '01',
          ),

        ],
      ),
    );
  }
}
