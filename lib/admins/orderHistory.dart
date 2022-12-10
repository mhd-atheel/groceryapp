import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groceryapp/admins/userOrders.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Order History",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xffF4F4F3),
        foregroundColor: Color(0xff2C5E30),
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserOrders()),
            );
          },
          icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,color: Color(0xff2C5E30),),
        ),
      ),
      body: Column(
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
                      'Najath Mohamed',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    subtitle: Text('najath@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text("Accepted",style: TextStyle(
                      color: Color(0xff27963c),
                      fontWeight: FontWeight.bold
                    ),),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Orders",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "broccoli",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                        Text(
                          "\$200",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Green Apple",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                        Text(
                          "\$80",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 16),
                    child: Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
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
                          "\$280",
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
                ],
              ),
            ),
          ),
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
                        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/grocery-app-9b16d.appspot.com/o/UserProfiles%2FTUgepKORCASTNqxwfjCzyeqaaQE3%2F1670436327588?alt=media&token=623a50b0-8770-40b8-9b50-c51fa60b2094',
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      'Aabith',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    subtitle: Text('aabith@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text("Decline",style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Orders",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "broccoli",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                        Text(
                          "\$200",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Green Apple",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                        Text(
                          "\$80",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 16),
                    child: Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
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
                          "\$280",
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
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
