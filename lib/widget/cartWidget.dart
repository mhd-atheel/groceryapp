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
            padding: const EdgeInsets.only(right:40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(
                      "2.20kg",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough),
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
                    Row(

                      children: [
                        GestureDetector(
                          onTap:(){
                            if(counter<=1){
                                  counter = 1;
                                  print(counter);
                                  final snackBar= SnackBar(
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,

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
                          child: Icon(FontAwesomeIcons.minus,size: 15,
                          ),
                        ),
                        SizedBox(width: 3,),
                        Text("$counter"),
                        SizedBox(width: 3,),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              counter ++;
                              print(counter);

                            });
                          },
                          child: Icon(FontAwesomeIcons.plus,size: 15,),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}