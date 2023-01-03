import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserOrderWidget extends StatefulWidget {
  final String name;
  final String email;
  final String total;
  final String status;
  final String id;
  bool isExpand;
  UserOrderWidget(
      {required this.name, required this.email, required this.total,required this.id,required this.isExpand,required this.status});

  @override
  State<UserOrderWidget> createState() => _UserOrderWidgetState();
}

class _UserOrderWidgetState extends State<UserOrderWidget> {
   bool isPress =false;
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
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff6ae792),
                    child: CachedNetworkImage(
                      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/grocery-app-9b16d.appspot.com/o/UserProfiles%2F0qBOYa9ml7SVgG5bZza2cWzwW5j1%2F1670590530628?alt=media&token=9986c87f-7347-4311-ad7b-bcc3d2d18580',
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  subtitle: Text(widget.email,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Container(

                    child: Text(widget.status,style: TextStyle(
                      color: widget.status =='Waiting'?Colors.orangeAccent:widget.status=='Decline'?Colors.red:Colors.green,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Totals",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                      Text(
                       '\$'+widget.total ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt'
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
               widget.isExpand==false?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                            {
                              'status':'Decline'
                            }
                        ).then((value) {
                          FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                              {
                                'isExpand':true
                              }
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 0,right: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffcccccc),
                            border: Border.all(color:Color(0xffcccccc)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],

                          ),
                          child: Center(
                            child: Text("Decline",style: TextStyle(
                                color: Color(0xff999999),
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                          {
                            'status':'Accepted'
                          }
                        ).then((value) {
                          FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
                              {
                                'isExpand':true
                              }
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0,left: 0,right: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff27963c),
                              border: Border.all(color:Color(0xff27963c) )

                          ),
                          child: Center(
                            child: Text("Accept",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),
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
