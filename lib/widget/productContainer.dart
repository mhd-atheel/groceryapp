import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../itemPage.dart';


class ProductContainer extends StatefulWidget {

  final Map data;

  ProductContainer({super.key,
    required this.data,

  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemPage(data: widget.data, )),
        );
      },
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width/2.3,
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
              imageUrl:  widget.data['downloadurl'],
              imageBuilder: (context, imageProvider) => Container(
                height: 80,
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
                      widget.data['symbol']=='item'?'${ widget.data['net']} ${ widget.data['symbol']}':
                     '${ widget.data['net']}${ widget.data['symbol']}',style:
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
              child: Text( widget.data['name'],style:
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
              child: Text('\$${ widget.data['price']}',style:
              TextStyle(
                  color: Color(0xff2C5E30),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt'
              )
                ,),
            ),
          ],
        ),
      ),
    );
  }
}
