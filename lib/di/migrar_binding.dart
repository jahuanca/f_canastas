
import 'package:flutter_actividades/data/repositories/tarea_proceso_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/tarea_proceso_repository.dart';
import 'package:flutter_actividades/domain/use_cases/migrar/migrar_all_tarea_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/migrar/upload_file_of_tarea_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/tareas/delete_tarea_proceso_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/tareas/get_all_tarea_proceso_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/tareas/update_tarea_proceso_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/migrar/migrar_controller.dart';
import 'package:get/get.dart';

class MigrarBinding extends Bindings{

  @override
  void dependencies() {

    Get.lazyPut<TareaProcesoRepository>(() => TareaProcesoRepositoryImplementation());

    Get.lazyReplace<MigrarAllTareaUseCase>(() => MigrarAllTareaUseCase(Get.find()));
    Get.lazyReplace<GetAllTareaProcesoUseCase>(() => GetAllTareaProcesoUseCase(Get.find()));
    Get.lazyReplace<UpdateTareaProcesoUseCase>(() => UpdateTareaProcesoUseCase(Get.find()));
    Get.lazyReplace<DeleteTareaProcesoUseCase>(() => DeleteTareaProcesoUseCase(Get.find()));
    Get.lazyReplace<UploadFileOfTareaUseCase>(() => UploadFileOfTareaUseCase(Get.find()));

    Get.lazyPut<MigrarController>(() => MigrarController(Get.find(), Get.find(), Get.find(), Get.find()));
    
  }

}