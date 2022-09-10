
import 'package:flutter_actividades/ui/pages/encuesta/elegir_opciones/elegir_opciones_controller.dart';
import 'package:get/get.dart';

class ElegirOpcionesBinding extends Bindings{

  int type;

  ElegirOpcionesBinding({this.type=0});

  @override
  void dependencies() {

    /* Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());
    Get.lazyPut<GetAllEncuestaUseCase>(() => GetAllEncuestaUseCase(Get.find())); */
    Get.lazyPut<ElegirOpcionesController>(() => ElegirOpcionesController(
      //Get.find()
    ));
    
  }

}