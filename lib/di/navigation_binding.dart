import 'package:flutter_canastas/di/aprobar_binding.dart';
import 'package:flutter_canastas/di/home_binding.dart';
import 'package:flutter_canastas/di/migrar_binding.dart';
import 'package:flutter_canastas/di/temporadas_binding.dart';
import 'package:flutter_canastas/ui/pages/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    HomeBinding().dependencies();
    TemporadasBinding().dependencies();
    //TareasBinding().dependencies();
    AprobarBinding().dependencies();
    MigrarBinding().dependencies();

    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}
