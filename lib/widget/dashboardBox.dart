import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:groceryapp/admins/categories.dart';
import 'package:groceryapp/admins/userOrders.dart';
import 'package:groceryapp/admins/users.dart';

import '../admins/products.dart';

class Functions {
  static Dashboard_box(context, bgcolor, name,  count) {
    return GestureDetector(
      onTap: () {
        if (name == "Categories") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Categories()),
          );
        } else if (name == "Products") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Products()),
          );
        } else if (name == "Orders") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserOrders()),
          );
        }
        else if (name == "Users") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Users()),
          );
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(bgcolor),
                    // 0xffEA40A6
                  ),
                  height:MediaQuery.of(context).size.height/5.4,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Prompt",
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          count<=9&&count>=0?'0'+count.toString():count.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,

                              fontSize: 40),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}