import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'loading.dart';

class UserOrderWidget extends StatefulWidget {
  final String name;
  final String email;
  final String total;
  final String status;
  final String id;
  final String image;
  bool isExpand;
  UserOrderWidget(
      {super.key, required this.name, required this.email, required this.total,required this.id,required this.isExpand,required this.status,required this.image});

  @override
  State<UserOrderWidget> createState() => _UserOrderWidgetState();
}

class _UserOrderWidgetState extends State<UserOrderWidget> {
   bool isPress =false;
   bool isDecline =false;
   bool isLoading =false;

   @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff6ae792),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  title: Text(
                    widget.name,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  subtitle:  Text(widget.email,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(widget.status,style: TextStyle(
                    color: widget.status =='Waiting'?Colors.orangeAccent:widget.status=='Decline'?Colors.red:Colors.green,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Totals",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                      Text(
                       '\$${widget.total}' ,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
               widget.isExpand==false?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if(mounted){
                          setState(() {
                            isDecline=true;
                          });
                        }
                        await Future.delayed(const Duration(seconds: 4));
                        
                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                            {
                              'status':'Decline'
                            }
                        ).then((value) {

                          FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                              {
                                'isExpand':true
                              }
                          ).then((value) {
                            if(mounted){
                              setState(() {
                                isDecline=false;
                              });
                            }
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 0,right: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffcccccc),
                            border: Border.all(color:const Color(0xffcccccc)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],

                          ),
                          child: Center(
                            child:isDecline==false?const Text("Decline",style: TextStyle(
                                color: Color(0xff999999),
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),):Loading(),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(mounted){
                          setState(() {
                            isLoading=true;
                          });
                        }

                        await Future.delayed(const Duration(seconds: 4));
                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                          {
                            'status':'Accepted'
                          }
                        ).then((value) {
                          FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                              {
                                'isExpand':true
                              }
                          ).then((value) {
                            if(mounted){
                              setState(() {
                                isLoading=false;
                              });
                            }
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 0,right: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff27963c),
                              border: Border.all(color:const Color(0xff27963c) )

                          ),
                          child: Center(
                            child:isLoading==false? const Text("Accept",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),):Loading(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ):Container()
              ],
            ),
          ),
        )
      ],
    );
  }
}
