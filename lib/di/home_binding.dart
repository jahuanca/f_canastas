
import 'package:flutter_actividades/ui/pages/entregable/home/home_controller.dart' as entregableHC;
import 'package:flutter_actividades/ui/pages/encuesta/home/home_controller.dart' as encuestaHC;
import 'package:get/get.dart';

class HomeBinding extends Bindings{

  int type;

  HomeBinding({this.type=0});

  @override
  void dependencies() {

    switch (type) {
      case 0:
        Get.lazyReplace<entregableHC.HomeController>(() => entregableHC.HomeController());
        break;
      case 1:
        Get.lazyReplace<encuestaHC.HomeController>(() => encuestaHC.HomeController());
        break;
      default:
    }
    
    
  }

}