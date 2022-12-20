import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class CartWidget extends StatefulWidget{
  final String img;
  final String name;
  final String price;
  final String net;
  final String symbol;
  final int quantity;

  CartWidget({
    super.key,
    required this.img,
    required this.name,
    required this.price,
    required this.quantity,
    required this.symbol,
    required this.net
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late int counter =  widget.quantity;

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
                Expanded(
                  child:CachedNetworkImage(
                    imageUrl: widget.img,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                              "${widget.net}${widget.symbol}",
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
                            Text('\$'+'${widget.price}',
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
                      // final snackBar= SnackBar(
                      //   backgroundColor: Colors.red,
                      //   behavior: SnackBarBehavior.floating,
                      //   duration: Duration(seconds: 1),
                      //   elevation: 0,
                      //   width: MediaQuery.of(context).size.width/1.1,
                      //   content: const Text('A minimum of 01 item is required',
                      //     style: TextStyle(fontWeight: FontWeight.bold),),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        position: MotionToastPosition.top,
                        animationType: AnimationType.fromTop,
                        animationDuration: Duration(milliseconds: 300),
                        dismissable: true,
                      ).show(context);
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
                Text("${counter}",style: TextStyle(
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