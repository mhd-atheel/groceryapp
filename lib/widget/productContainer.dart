import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../itemPage.dart';


class ProductContainer extends StatefulWidget {
  final String net;
  final String name;
  final String img;
  final String price;
  final String symbol;

  ProductContainer({super.key,
    required this.net,
    required this.name,
    required this.img,
    required this.price,
    required this.symbol
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemPage(name: widget.name,net: widget.net,img: widget.img,price: widget.price, )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),
            child: Container(
              height: 180,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.img,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 110,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5,),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff2C5E30),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 6),
                          child: Text(
                           '${widget.net}${widget.symbol}',style:
                          TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          )
                            ,),
                        ),
                      ),
                      SizedBox(width: 5,),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,top:0),
                    child: Text(widget.name,style:
                    TextStyle(
                        color: Color(0xff2F3825),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prompt'
                    )
                      ,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,top: 0),
                    child: Text('\$${widget.price}',style:
                    TextStyle(
                        color: Color(0xff2C5E30),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt'
                    )
                      ,),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10.0,left: 5),
                  //   child: Row(
                  //     children: [
                  //       Text(net,style:
                  //       TextStyle(
                  //         color:Colors.grey.shade600,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //       )
                  //         ,)
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
