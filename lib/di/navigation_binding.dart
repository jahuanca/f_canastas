import 'package:flutter_actividades/di/aprobar_binding.dart';
import 'package:flutter_actividades/di/encuestas_binding.dart';
import 'package:flutter_actividades/di/home_binding.dart';
import 'package:flutter_actividades/di/migrar_binding.dart';
import 'package:flutter_actividades/di/temporadas_binding.dart';
import 'package:flutter_actividades/ui/pages/entregable/navigation/navigation_controller.dart' as entregableNC;
import 'package:flutter_actividades/ui/pages/encuesta/navigation/navigation_controller.dart' as encuestaNC;
import 'package:get/get.dart';

class NavigationBinding extends Bindings {

  int type;

  NavigationBinding({this.type=0});

  @override
  void dependencies() {
    HomeBinding(type: type).dependencies();
    TemporadasBinding().dependencies();
    //TareasBinding().dependencies();
    AprobarBinding().dependencies();
    MigrarBinding().dependencies();


    switch (type) {
      case 0:
        Get.lazyReplace<entregableNC.NavigationController>(() => entregableNC.NavigationController());    
        break;
      case 1:
        EncuestasBinding().dependencies();
        Get.lazyReplace<encuestaNC.NavigationController>(() => encuestaNC.NavigationController());
        break;
      
      default:
    }
  }
}
