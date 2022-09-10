
import 'package:flutter_actividades/data/repositories/encuesta_detalle_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_opciones_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_opciones_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/get_all_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_by_values_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/graficos_encuesta/graficos_encuesta_controller.dart';
import 'package:get/get.dart';

class GraficosEncuestaBinding extends Bindings{

  int type;

  GraficosEncuestaBinding({this.type=0});

  @override
  void dependencies() {

    Get.lazyPut<EncuestaDetalleRepository>(() => EncuestaDetalleRepositoryImplementation());
    Get.lazyPut<EncuestaOpcionesRepository>(() => EncuestaOpcionesRepositoryImplementation());

    Get.lazyPut<GetAllEncuestaDetalleUseCase>(() => GetAllEncuestaDetalleUseCase(Get.find()));
    Get.lazyPut<GetAllEncuestaOpcionesByValuesUseCase>(() => GetAllEncuestaOpcionesByValuesUseCase(Get.find()));

    Get.lazyPut<GraficosEncuestaController>(() => GraficosEncuestaController(
      Get.find(),
      Get.find(),
    ));
    
  }

}