import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        Text(name)
      ],
    );
  }
  items(discoutnprice,price,img,desc,net){
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),
          child: Container(
            height: 200,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffEEF2F9),
            ),
            child: Column(
              children: [

                Container(
                  height: 120,
                  width: 130,
                  child: Image.asset(img,height: 120 ,fit: BoxFit.contain,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5,),
                    Text(discoutnprice,style:
                    TextStyle(
                        color: Color(0xff00be5e),
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    )
                      ,),
                    SizedBox(width: 5,),
                    Text(price,style:
                    TextStyle(
                        color:Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough

                    )
                      ,)
                  ],
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                  child: Text(desc,style:
                  TextStyle(
                      color: Colors.grey,
                      fontSize: 10
                  )
                    ,),
                )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0,left: 5),
                  child: Row(
                    children: [
                      Text(net,style:
                      TextStyle(
                        color:Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )
                        ,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            width: 30,
            height: 15,
            decoration: BoxDecoration(
                color: Color(0xffffa31a),
                borderRadius: BorderRadius.circular(2)
            ),
            child: Center(child: Text("10%",style:
            TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600),
            )),
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
                          borderRadius: BorderRadius.circular(5)),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "What do you looking for?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 11,),
                    items("\$0.14","\$0.22",'assets/images/spinach.png',"Fresh Broccoli Premium item from Thailand","200gr"),
                    items("\$0.14","\$0.22",'assets/images/broc.png',"Fresh Broccoli Premium item from Thailand","200gr"),
                    items("\$0.28","\$0.44",'assets/images/greenapple.png',"Fresh Apple Premium item from England","2 Items"),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Recommend for you",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 11,),
                    items("\$0.14","\$0.22",'assets/images/strawberry.png',"Fresh strawberry Premium item from Nuwerliya","250gr"),
                    items("\$0.14","\$0.22",'assets/images/banana.png',"Yellowish Banana Premium item from Lanka","200gr"),
                    items("\$0.28","\$0.44",'assets/images/orange.png'," Wow Orange Premium item from England","6 Items"),

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
