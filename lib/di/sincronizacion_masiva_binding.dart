
import 'package:flutter_actividades/data/repositories/encuesta_detalle_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/get_all_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/migracion_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/update_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/sincronizacion_masivo/sincronizacion_masiva_controller.dart';
import 'package:get/get.dart';

class SincronizacionMasivaBinding extends Bindings{

  int type;

  SincronizacionMasivaBinding({this.type=0});

  @override
  void dependencies() {

    Get.lazyPut<EncuestaDetalleRepository>(() => EncuestaDetalleRepositoryImplementation());
    Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());

    Get.lazyPut<GetAllEncuestaDetalleUseCase>(() => GetAllEncuestaDetalleUseCase(Get.find()));
    Get.lazyPut<MigracionEncuestaDetalleUseCase>(() => MigracionEncuestaDetalleUseCase(Get.find()));
    Get.lazyPut<UpdateEncuestaDetalleUseCase>(() => UpdateEncuestaDetalleUseCase(Get.find()));
    Get.lazyPut<UpdateEncuestaUseCase>(() => UpdateEncuestaUseCase(Get.find()));

    Get.lazyPut<SincronizacionMasivaController>(() => SincronizacionMasivaController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
    
  }

}