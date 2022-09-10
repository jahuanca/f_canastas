
import 'package:flutter_actividades/di/navigation_binding.dart';
import 'package:flutter_actividades/di/sincronizar_binding.dart';
import 'package:flutter_actividades/di/splash_binding.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings{


  @override
  void dependencies() {

    SplashBinding(type: -1).dependencies();

    SincronizarBinding().dependencies(); 

    NavigationBinding().dependencies();
    
  }

}