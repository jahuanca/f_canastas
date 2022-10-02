
import 'package:flutter_actividades/data/repositories/encuesta_detalle_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_opciones_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_empresa_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_respuestas_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_opciones_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_respuesta_repository.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/create_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/delete_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/get_all_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/migrar_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/update_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta_detalle/encuesta_detalle_controller.dart';
import 'package:get/get.dart';

class EncuestaDetalleBinding extends Bindings{

  int type;

  EncuestaDetalleBinding({this.type=0});

  @override
  void dependencies() {

    Get.lazyPut<PersonalEmpresaRepository>(() => PersonalEmpresaRepositoryImplementation());
    Get.lazyPut<EncuestaOpcionesRepository>(() => EncuestaOpcionesRepositoryImplementation());
    Get.lazyPut<EncuestaDetalleRepository>(() => EncuestaDetalleRepositoryImplementation());
    Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());
    Get.lazyPut<PersonalRespuestasRepository>(() => PersonalRespuestasRepositoryImplementation());


    Get.lazyPut<GetPersonalsEmpresaUseCase>(() => GetPersonalsEmpresaUseCase(Get.find()));
    Get.lazyPut<GetAllPersonalRespuestasUseCase>(() => GetAllPersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<GetAllEncuestaOpcionesByValuesUseCase>(() => GetAllEncuestaOpcionesByValuesUseCase(Get.find()));
    Get.lazyPut<CreatePersonalRespuestasUseCase>(() => CreatePersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<UpdatePersonalRespuestasUseCase>(() => UpdatePersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<DeletePersonalRespuestasUseCase>(() => DeletePersonalRespuestasUseCase(Get.find()));
    Get.lazyPut<MigrarPersonalRespuestasUseCase>(() => MigrarPersonalRespuestasUseCase(Get.find()));
    
    Get.lazyPut<UpdateEncuestaUseCase>(() => UpdateEncuestaUseCase(Get.find()));


    Get.lazyPut<EncuestaDetalleController>(() => EncuestaDetalleController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
    
  }

}