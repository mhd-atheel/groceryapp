

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
class IsLoading{
   static bool isLoading  = false;
}
