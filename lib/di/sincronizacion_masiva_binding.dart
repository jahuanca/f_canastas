
import 'package:flutter_actividades/data/repositories/encuesta_detalle_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_respuestas_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_respuesta_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/get_all_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/migracion_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/update_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/get_all_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/update_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/sincronizacion_masivo/sincronizacion_masiva_controller.dart';
import 'package:get/get.dart';

class SincronizacionMasivaBinding extends Bindings{

  int type;

  SincronizacionMasivaBinding({this.type=0});

  @override
  void dependencies() {

    Get.lazyPut<PersonalRespuestasRepository>(() => PersonalRespuestasRepositoryImplementation());
    Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());

    Get.lazyPut<GetAllPersonalRespuestasUseCase>(() => GetAllPersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<MigracionPersonalRespuestasUseCase>(() => MigracionPersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<UpdatePersonalRespuestasUseCase>(() => UpdatePersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<UpdateEncuestaUseCase>(() => UpdateEncuestaUseCase(Get.find()));

    Get.lazyPut<SincronizacionMasivaController>(() => SincronizacionMasivaController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
    
  }

}