import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/widget/categoriesHome.dart';
import 'package:groceryapp/widget/productContainer.dart';


import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name;
  late String net;
  late String img = '';
  late String price;
  String productName = 'Meats';
  int isState = 0;

  final List<String> images = [
   'assets/images/banner3.jpg',
   'assets/images/banner2.jpg',
   'assets/images/banner1.jpg',
  ];
  tabWidget(name){
    GestureDetector(
      onTap: (){
        if(name=="Vegetables"){
          setState(() {
            productName= 'Vegetables';
            isState=1;
          });
        }else{
          setState(() {
            productName= 'Fruits';
            isState=1;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:isState==0?Color(0xff27963c):Colors.white,
              border: Border.all(
                  color: isState==0?Colors.white:Color(0xff27963c)
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:8.0,left: 16,right: 16,top: 8),
                child: Text(name,style: TextStyle(
                    color: isState==0?Colors.white:Color(0xff27963c),
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),),
              ),
            ],
          ),
        ),
      ),
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
                    CategoriesHome(name: "Vegetables", img: 'assets/images/veg.png'),
                    CategoriesHome(name: "Fruits", img: 'assets/images/fruits.png'),
                    CategoriesHome(name: "Meats", img: 'assets/images/meat.png'),
                    CategoriesHome(name: "SeaFoods", img: 'assets/images/fish.png'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoriesHome(name: "Milk and Egg", img: 'assets/images/milk.png'),
                    CategoriesHome(name: "Breads", img: 'assets/images/bread.png'),
                    CategoriesHome(name: "Frozen", img: 'assets/images/frozen.png'),
                    CategoriesHome(name: "Organic", img: 'assets/images/organic.png'),

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
              SizedBox(
                  height: 180.0,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                    itemCount:images.length,
                    options: CarouselOptions(
                      autoPlay: true,

                    ),
                    itemBuilder: (context, index, realIdx) {
                      return Container(
                        child: Center(
                            child: Image.asset(images[index],
                                fit: BoxFit.cover,)),
                      );
                    },
                  )),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Column(
              //       children: [
              //
              //        tabWidget('Vegetables'),
              //        tabWidget('Vegetables'),
              //       ],
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Products for You",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Prompt'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  productName= 'Fruits';
                });
                print('clicked');
              }, child: Text("Click")),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('products').where('categories',isEqualTo: productName).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                         mainAxisSpacing: 20,
                      ),
                      primary: false,
                      // crossAxisSpacing: 10,
                      // mainAxisSpacing: 20,
                      // crossAxisCount: 2,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        data['id'] = document.id;
                        return ProductContainer(
                          data: data,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
