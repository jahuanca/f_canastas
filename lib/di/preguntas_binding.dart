
import 'package:flutter_actividades/ui/pages/encuesta/preguntas/preguntas_controller.dart';
import 'package:get/get.dart';

class PreguntasBinding extends Bindings{

  int type;

  PreguntasBinding({this.type=0});

  @override
  void dependencies() {

    /* Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());
    Get.lazyPut<GetAllEncuestaUseCase>(() => GetAllEncuestaUseCase(Get.find())); */
    Get.lazyPut<PreguntasController>(() => PreguntasController(
      //Get.find()
    ));
    
  }

}