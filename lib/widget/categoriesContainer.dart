import 'package:flutter/material.dart';

class CategoriesContainer extends StatefulWidget {

   final String img;
   final String name;
   final String quantity;
   CategoriesContainer({
     super.key,
     required this.img,
     required this.name,
     required this.quantity
   });

  @override
  State<CategoriesContainer> createState() => _CategoriesContainerState();
}

class _CategoriesContainerState extends State<CategoriesContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 16),
      child: ListTile(
          shape: RoundedRectangleBorder( //<-- SEE HERE
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          leading: CircleAvatar(
              backgroundColor: const Color(0xff6ae792),
              child: Image.asset(widget.img)
          ),
          title: Text(
            widget.name,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400
            ),
          ),
          // subtitle: Text('25',
          //   style: TextStyle(
          //     fontFamily: 'Poppins',
          //     fontWeight: FontWeight.w200,
          //     fontSize: 12,
          //   ),
          // ),
          trailing: Text(widget.quantity,style: TextStyle(
              color: Color(0xff2C5E30),
              fontWeight: FontWeight.bold,
              fontSize: 20),
          )
      ),
    );
  }
}
