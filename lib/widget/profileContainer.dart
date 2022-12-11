import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imageUrl;
  ProfileContainer(
      {required this.name, required this.email, required this.phone, required this.address, required this.imageUrl});



  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                radius: 100,
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Center(
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none, // This is what you need.
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                        child: Text(
                          widget.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              Positioned(
                top: 0,
                left: 20,
                child: Container(
                  width: 123,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Color(0xff27963c),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        'Name',style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Prompt"
                      ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              //Container
            ],
            //<Widget>[]
          ),
        ),
        Center(
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none, // This is what you need.
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                        child: Text(
                          widget.email.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              Positioned(
                top: 0,
                left: 20,
                child: Container(
                  width: 123,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Color(0xff27963c),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        'Email',style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Prompt"
                      ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              //Container
            ],
            //<Widget>[]
          ),
        ),
        Center(
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none, // This is what you need.
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                        child: Text(
                          widget.address.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              Positioned(
                top: 0,
                left: 20,
                child: Container(
                  width: 123,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Color(0xff27963c),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        'Address',style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Prompt"
                      ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              //Container
            ],
            //<Widget>[]
          ),
        ),
        Center(
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none, // This is what you need.
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 15),
                        child: Text(
                          widget.phone.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Prompt'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              Positioned(
                top: 0,
                left: 20,
                child: Container(
                  width: 123,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Color(0xff27963c),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        'Phone Number',style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Prompt"
                      ),
                      ),
                    ],
                  ),
                ),
              ), //Container
              //Container
            ],
            //<Widget>[]
          ),
        ),
      ],
    );
  }
}
