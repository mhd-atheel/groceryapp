import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RelatedProductsContainer extends StatefulWidget {
  final String name;
  final String downloadUrl;


  RelatedProductsContainer({required this.name, required this.downloadUrl});

  @override
  State<RelatedProductsContainer> createState() => _RelatedProductsContainerState();
}

class _RelatedProductsContainerState extends State<RelatedProductsContainer> {
  @override
  Widget build(BuildContext context) {
    return                       Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onTap: (){
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
            child: Container(
              height: 150,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:  widget.downloadUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 120,
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

                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
