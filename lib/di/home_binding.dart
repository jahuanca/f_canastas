
import 'package:flutter_canastas/ui/pages/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut<HomeController>(() => HomeController());
    
  }

}