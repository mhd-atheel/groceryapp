import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderContainer extends StatelessWidget {
  final String orderId;
  final String deliveryAt;
  final String total;
  final Timestamp date;
  final String status;


  OrderContainer(
      { required this.orderId,
        required this.deliveryAt,
        required this.total,
        required this.date,
        required this.status
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16,top: 5),
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width,
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
        child: Column(
          children: [
            const SizedBox(height:10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:status =='Waiting'?Colors.orangeAccent:status=='Decline'?Colors.red:Colors.green,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                        child: Text(
                          status,
                          style:const TextStyle(
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(

                    children: [
                      Text(date.toDate().toString().substring(0,10),
                        style:const  TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),),
                      const Text(' |',
                        style:TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                      Text(date.toDate().toString().substring(10,16),
                        style:const  TextStyle(color: Colors.black26,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0,top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("Transaction ID",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('#$orderId',style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Delivary to",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                            ],
                          ),
                          Row(
                            children: [
                              Text(deliveryAt,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Total Payment",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize:12),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("\$"+total,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
