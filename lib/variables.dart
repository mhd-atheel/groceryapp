


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class  Variable extends GetxController {
   RxInt totalPrice = 0.obs;
   RxInt itemCount = 1.obs;

}
class  ItemVariable extends GetxController {
   RxInt itemCount = 1.obs;
}
class  HomeVariable extends GetxController {
   RxInt tabVale = 1.obs;
   RxInt isState = 0.obs;
   RxString productName = 'All'.obs;
}

class AdminHomeVariable extends GetxController{
   RxInt orderCount = 0.obs;
   RxInt userCount = 0.obs;
   RxInt productCount = 0.obs;
   RxInt categoriesCount = 8.obs;

   getValue()async{
      await FirebaseFirestore.instance.collection('orders').get(
      ).then((value) {
         return orderCount = value.size as RxInt;
      });
      return orderCount;
   }
}



class IsLoading{
   static bool isLoading  = false;
}
