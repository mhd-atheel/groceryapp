import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/main.dart';
class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          "Products",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavbar()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff00e673),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.cartShopping,size: 20,color: Color(0xff00e673),),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/3.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
                    'assets/images/spinach.png',
                    height: MediaQuery.of(context).size.height/3.5,
                    width:  MediaQuery.of(context).size.width,

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Orange",
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.heart,size: 20,color: Color(0xff00e673),),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "It is a long established fact that a reader will be  by the"
                      " readable content of a page when looking at its layout. The point o"
                      "f using Lorem Ipsum is that it has a more-or-less normal distribution of letters, "
                      "as oppo to using 'Content here, content here', making it look like",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15,color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Color(0xff6dde9a))

                      ),
                      child: Center(
                        child: Text("200gr",style: TextStyle(

                            fontWeight: FontWeight.bold,
                            fontSize: 10
                        ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:10.0),
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
                            child: Icon(FontAwesomeIcons.minus,size: 25,
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text("$counter",style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),),
                          SizedBox(width: 3,),
                          GestureDetector(
                            onTap:(){
                              setState(() {
                                counter ++;
                                print(counter);
                              });
                            },
                            child: Icon(FontAwesomeIcons.plus,size: 25,),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        "\$120",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0,left: 7.5,right: 7.5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff6dde9a),

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
