import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/homepage.dart';
import 'package:groceryapp/main.dart';
class ItemPage extends StatefulWidget {
  String itemName;
  String net;
  String img;
  String price;

   ItemPage({Key? key, required this.itemName, required this.net, required this.img, required this.price}) : super(key: key);
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavbar()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.cartShopping,size: 20,color: Color(0xff2C5E30),),
            ),
          ),
        ],
        // backgroundColor: Color(0xffF4F4F3),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff2C5E30),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(widget.itemName,style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Prompt'
              ),),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/4.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade100,
                    //     spreadRadius: 2,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Image.asset(
                    widget.img,
                    height: MediaQuery.of(context).size.height/3.5,
                    width:  MediaQuery.of(context).size.width,

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0,top: 0),
                      child: Text('${widget.price}',style:
                      TextStyle(
                          color: Color(0xff2F3825),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt'
                      )
                        ,),
                    ),
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
                          child: Icon(Icons.remove_circle_outline_rounded,size: 40,
                          ),
                        ),
                        SizedBox(width: 6,),
                        Text("$counter",style: TextStyle(
                          fontSize: 25
                        ),),
                        SizedBox(width: 6,),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              counter ++;
                              print(counter);

                            });
                          },
                          child: Icon(Icons.add_circle_outline_rounded,size: 40,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text("Description",style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("It is a long established fact that a reader will be distra by t"
                          "he readable  will be distracted by thunge is state controller established fact life",style: TextStyle(
                          fontWeight: FontWeight.normal,color: Colors.black38,fontFamily: 'Prompt'
                      ),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                child: Row(
                  children: [
                    Text("Realated Products",style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BottomNavbar()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                            child: Container(
                              height: 130,
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

                                  Container(
                                    height: 100,
                                    width: 110,
                                    child: Image.asset('assets/images/broc.png',height: 120 ,fit: BoxFit.contain,),
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
                                    child: Text('Orange',style:
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
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BottomNavbar()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                            child: Container(
                              height: 130,
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

                                  Container(
                                    height: 100,
                                    width: 110,
                                    child: Image.asset('assets/images/orange.png',height: 120 ,fit: BoxFit.contain,),
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
                                    child: Text('Orange',style:
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
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BottomNavbar()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                            child: Container(
                              height: 130,
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

                                  Container(
                                    height: 100,
                                    width: 110,
                                    child: Image.asset('assets/images/spinach.png',height: 120 ,fit: BoxFit.contain,),
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
                                    child: Text('Orange',style:
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
                    ),
                  ],
                ),
              ),

            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0,left: 16,right: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffffa31a),

                  ),
                  child: Center(
                    child: Text("Add to Cart",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),
                  ),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
