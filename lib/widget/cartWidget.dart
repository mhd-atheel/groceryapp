import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartWidget extends StatefulWidget{
  final String img;
  final String name;
  final String price;

  CartWidget({
    super.key,
    required this.img,
    required this.name,
    required this.price

  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 281,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 120,
                  width: 130,
                  child: Image.asset(
                    widget.img,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right:0,left: 0),
                  child: Container(
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:20),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height:5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "2.00kg",
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        SizedBox(height:5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.price,
                              style: TextStyle(
                                color: Color(0xff00be5e),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 120,),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(

              children: [
                GestureDetector(
                  onTap:(){
                    if(counter<=1){
                      counter = 1;
                      print(counter);
                      final snackBar= SnackBar(
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                        elevation: 0,
                        width: MediaQuery.of(context).size.width/1.1,
                        content: const Text('A minimum of 01 item is required',
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else{
                      setState(() {
                        counter--;
                        print(counter);
                      });
                    }

                  },
                  child: Icon(Icons.remove_circle_outline_rounded,size: 30,
                  ),
                ),
                SizedBox(width: 3,),
                Text("$counter",style: TextStyle(
               fontSize: 20
                   ),),
                SizedBox(width: 3,),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      counter ++;
                      print(counter);

                    });
                  },
                  child: Icon(Icons.add_circle_outline_rounded,size: 30,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}