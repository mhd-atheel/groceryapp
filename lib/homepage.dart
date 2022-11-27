import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/itemPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String itemName;
  late String net;
  late String img = '';
  late String price;
  categories(img,name) {
    return Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 4.7,
          decoration: BoxDecoration(
            color: Colors.white,
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
            img,
            height: 60,
            width: 60,
            scale: 12,
          ),
        ),
        SizedBox(height: 5),
        Text(name,style: TextStyle(
          fontFamily: 'Prompt'
        ),)
      ],
    );
  }
  items(net,name,img,price){
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemPage(itemName: name,net: net,img: img,price: price, )),
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

                  Container(
                    height: 100,
                    width: 110,
                    child: Image.asset(img,height: 120 ,fit: BoxFit.contain,),
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
                          child: Text(net,style:
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
                    child: Text(name,style:
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
                    child: Text(price,style:
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              Row(
                children: [
                  // SizedBox(width: 10,),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 0),
                        child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Search Products ',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  size: 16,
                                  color: Colors.grey,
                                ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    FontAwesomeIcons.bell,
                    size: 23,
                    color: Color(0xff00e673),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "What do you looking for?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categories('assets/images/veg.png',"Vegitables"),
                    categories('assets/images/fruits.png',"Fruits"),
                    categories('assets/images/meat.png',"Meats"),
                    categories('assets/images/fish.png',"Sea foods"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categories('assets/images/milk.png',"Milk & Egg"),
                    categories('assets/images/bread.png',"Breads"),
                    categories('assets/images/frozen.png',"Frozen"),
                    categories('assets/images/organic.png',"Organic"),
                  ],
                ),
              ),
              SizedBox(height:18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Promations for you?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                    height: 180.0,

                    width: MediaQuery.of(context).size.width,
                    child: Carousel(
                      images: [
                        Image.asset('assets/images/banner3.jpg',fit: BoxFit.cover,),
                        Image.asset('assets/images/banner1.jpg',fit: BoxFit.cover,),
                        Image.asset('assets/images/banner2.jpg',fit: BoxFit.cover,),
                      ],
                      dotSize: 0.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.transparent,
                      borderRadius: true,
                      autoplay: false,

                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Fresh Vegan",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 11,),
                    items("200gr","Spinach",'assets/images/spinach.png',"\$20"),
                    items("500gr","Broccoli",'assets/images/broc.png',"\$30.5"),
                    items("1kg","Apple",'assets/images/greenapple.png',"\$24"),
                    items("500gr","Strawberry",'assets/images/strawberry.png',"\$22"),
                    items("1kg","Orange",'assets/images/orange.png',"\$18"),
                    items("1kg","Banana",'assets/images/banana.png',"\$12"),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Recommend for you",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 11,),
                    items("500gr","Strawberry",'assets/images/strawberry.png',"\$22"),
                    items("1kg","Orange",'assets/images/orange.png',"\$18"),
                    items("1kg","Banana",'assets/images/banana.png',"\$12"),
                    items("200gr","Spinach",'assets/images/spinach.png',"\$20"),
                    items("500gr","Broccoli",'assets/images/broc.png',"\$30.5"),
                    items("1kg","Apple",'assets/images/greenapple.png',"\$24"),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
