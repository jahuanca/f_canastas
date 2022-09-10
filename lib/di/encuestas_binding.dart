
import 'package:flutter_actividades/data/repositories/encuesta_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/get_all_encuesta_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/encuestas/encuestas_controller.dart';
import 'package:get/get.dart';

class EncuestasBinding extends Bindings{

  int type;

  EncuestasBinding({this.type=0});

  @override
  void dependencies() {

    Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());
    Get.lazyPut<GetAllEncuestaUseCase>(() => GetAllEncuestaUseCase(Get.find()));
    Get.lazyPut<EncuestasController>(() => EncuestasController(
      Get.find()
    ));
    
  }

}