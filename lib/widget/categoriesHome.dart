import 'package:flutter/material.dart';
import 'package:groceryapp/categories.dart';

class CategoriesHome extends StatelessWidget {
  final String name;
  final String img;

  CategoriesHome({required this.name, required this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Categories(name:name)),
        );
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 4.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              img,
              height: 60,
              width: 60,
              scale: 12,
            ),
          ),
          SizedBox(height: 5),
          Text(name,style: TextStyle(
              fontFamily: 'Prompt'
          ),)
        ],
      ),
    );
  }
}
