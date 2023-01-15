import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/admins/adminHome.dart';



class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool isAdmin =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          },
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 20,
            color: Color(0xff2C5E30),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('biodata').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff6ae792),
                    child: CachedNetworkImage(
                      imageUrl: data['downloadurl'],
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['name'],
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                      ),

                      data['userType']=='admin'?Container(
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2),
                          child: Center(
                            child: Text(
                              'Admin',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontWeight: FontWeight.bold,fontSize: 10,color: Colors.white),
                            ),
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                  subtitle: Text(
                    data['email'],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                    ),
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                child: const Text(
                                  'Are you sure to ?',
                                  style: TextStyle(fontFamily: 'Prompt'),
                                ),
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.green,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      child: Center(child: data['userType']=='user'?Text('Make Admin',style: TextStyle(fontFamily: 'Prompt',color: Colors.green,fontWeight: FontWeight.bold),):
                                      Text('Remove Admin',style: TextStyle(fontFamily: 'Prompt',color: Colors.green,fontWeight: FontWeight.bold),)),
                                      onPressed: () async {
                                        FirebaseFirestore.instance.collection('biodata').doc(document.id).get().
                                        then((value){
                                          String userType = value.data()!['userType'];
                                          if(userType=='user'){
                                            FirebaseFirestore.instance.collection('biodata').doc(document.id).update(
                                              {
                                                'userType':'admin'
                                              }
                                            ).then((value) {
                                              setState(() {
                                                isAdmin=true;
                                              });
                                              Navigator.pop(context);
                                            });
                                          }
                                          if(userType=='admin'){
                                            FirebaseFirestore.instance.collection('biodata').doc(document.id).update(
                                                {
                                                  'userType':'user'
                                                }
                                            ).then((value){
                                              Navigator.pop(context);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.red,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      child: Center(child: const Text('Delete',style: TextStyle(fontFamily: 'Prompt',color: Colors.red,fontWeight: FontWeight.bold),)),
                                      onPressed: () async {
                                      },
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: Center(child: const Text('Cancel',style: TextStyle(fontFamily: 'Prompt'),)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),

                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.more_vert)),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
