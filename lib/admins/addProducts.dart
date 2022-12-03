import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Add New Products",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text("Product Name ",style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 15,
                    color: Color(0xff2F3825)
                ),),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                // 0xfff2f2f2  - like a gray
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black54)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: TextField(

                    decoration: InputDecoration(
                      hintText: 'Product Name ',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text("Price ",style: TextStyle(
                    fontFamily: "Prompt",
                    fontSize: 15,
                    color: Color(0xff2F3825)
                ),),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                // 0xfff2f2f2  - like a gray
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black54)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: TextField(

                    decoration: InputDecoration(
                      hintText: 'price ',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
