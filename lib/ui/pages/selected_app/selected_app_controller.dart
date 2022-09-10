
import 'package:flutter_actividades/di/splash_binding.dart';
import 'package:flutter_actividades/ui/pages/encuesta/splash/splash_page.dart' as encuesta;
import 'package:flutter_actividades/ui/pages/entregable/splash/splash_page.dart' as entregable;
import 'package:get/get.dart';

class SelectedAppController extends GetxController{

  goEncuesta(){
    SplashBinding(type: 1).dependencies();
    Get.to(()=> encuesta.SplashPage());
  }

  goEntregable(){
    SplashBinding(type: 0).dependencies();
    Get.to(()=> entregable.SplashPage());
  }
  
}