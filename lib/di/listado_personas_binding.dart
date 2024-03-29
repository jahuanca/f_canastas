
import 'package:flutter_actividades/data/repositories/personal_empresa_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_personal_empresa_by_subdivision_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/tareas/update_tarea_proceso_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_personas/listado_personas_controller.dart';
import 'package:get/get.dart';

class ListadoPersonasBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut<PersonalEmpresaRepository>(() => PersonalEmpresaRepositoryImplementation());

    Get.lazyPut<GetPersonalsEmpresaBySubdivisionUseCase>(() => GetPersonalsEmpresaBySubdivisionUseCase(Get.find()));
    Get.lazyPut<UpdateTareaProcesoUseCase>(() => UpdateTareaProcesoUseCase(Get.find()));

    Get.lazyPut<ListadoPersonasController>(() => ListadoPersonasController(Get.find(), Get.find()));
    
  }

}