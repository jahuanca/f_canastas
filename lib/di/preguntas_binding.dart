
import 'package:flutter_actividades/data/repositories/encuesta_campo_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_etapa_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_turno_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/unidad_negocio_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_campo_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_etapa_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_turno_repository.dart';
import 'package:flutter_actividades/domain/repositories/unidad_negocio_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_campos_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_etapas_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_turnos_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_unidad_negocios_by_values_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/preguntas/preguntas_controller.dart';
import 'package:get/get.dart';

class PreguntasBinding extends Bindings{

  int type;

  PreguntasBinding({this.type=0});

  @override
  void dependencies() {


    Get.lazyPut<UnidadNegocioRepository>(() => UnidadNegocioRepositoryImplementation());
    Get.lazyPut<EncuestaEtapaRepository>(() => EncuestaEtapaRepositoryImplementation());
    Get.lazyPut<EncuestaCampoRepository>(() => EncuestaCampoRepositoryImplementation());
    Get.lazyPut<EncuestaTurnoRepository>(() => EncuestaTurnoRepositoryImplementation());

    Get.lazyReplace<GetUnidadNegociosByValuesUseCase>(() => GetUnidadNegociosByValuesUseCase(Get.find()));
    Get.lazyReplace<GetEncuestaCamposByValuesUseCase>(() => GetEncuestaCamposByValuesUseCase(Get.find()));
    Get.lazyReplace<GetEncuestaEtapasByValuesUseCase>(() => GetEncuestaEtapasByValuesUseCase(Get.find()));
    Get.lazyReplace<GetEncuestaTurnosByValuesUseCase>(() => GetEncuestaTurnosByValuesUseCase(Get.find()));

    Get.lazyPut<PreguntasController>(() => PreguntasController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
    
  }

}