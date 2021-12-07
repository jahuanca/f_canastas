import 'package:flutter_canastas/data/repositories/actividad_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/labor_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/pre_tarea_esparrago_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/vehiculo_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/vehiculo_temporada_repository_implementation.dart';
import 'package:flutter_canastas/domain/repositories/actividad_repository.dart';
import 'package:flutter_canastas/domain/repositories/labor_repository.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_repository.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_repository.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_temporada_repository.dart';
import 'package:flutter_canastas/domain/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_labors_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_vehiculos_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/temporadas/get_actividads_by_key_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/vehiculo_temporada/create_vehiculo_temporada_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/vehiculo_temporada/delete_vehiculo_temporada_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/vehiculo_temporada/get_all_vehiculo_temporada_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/vehiculo_temporada/migrar_all_vehiculo_temporada_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/vehiculo_temporada/update_vehiculo_temporada_use_case.dart';
import 'package:flutter_canastas/ui/pages/listado_vehiculo_temporada/listado_vehiculo_temporada_controller.dart';
import 'package:get/get.dart';

class ListadoVehiculoTemporadaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehiculoRepository>(() => VehiculoRepositoryImplementation());
    Get.lazyPut<VehiculoTemporadaRepository>(
        () => VehiculoTemporadaRepositoryImplementation());
    Get.lazyPut<ActividadRepository>(() => ActividadRepositoryImplementation());
    Get.lazyPut<LaborRepository>(() => LaborRepositoryImplementation());
    Get.lazyPut<PreTareaEsparragoRepository>(
        () => PreTareaEsparragoRepositoryImplementation());

    Get.lazyPut<GetVehiculosUseCase>(() => GetVehiculosUseCase(Get.find()));
    Get.lazyPut<UpdateVehiculoTemporadaUseCase>(
        () => UpdateVehiculoTemporadaUseCase(Get.find()));
    Get.lazyPut<GetActividadsUseCase>(() => GetActividadsUseCase(Get.find()));
    Get.lazyPut<GetLaborsUseCase>(() => GetLaborsUseCase(Get.find()));
    Get.lazyPut<CreateVehiculoTemporadaUseCase>(
        () => CreateVehiculoTemporadaUseCase(Get.find()));
    Get.lazyPut<MigrarAllVehiculoTemporadaUseCase>(
        () => MigrarAllVehiculoTemporadaUseCase(Get.find()));
    Get.lazyPut<DeleteVehiculoTemporadaUseCase>(
        () => DeleteVehiculoTemporadaUseCase(Get.find()));
    Get.lazyPut<GetAllVehiculoTemporadaUseCase>(
        () => GetAllVehiculoTemporadaUseCase(Get.find()));

    Get.lazyPut<ListadoVehiculoTemporadaController>(() =>
        ListadoVehiculoTemporadaController(Get.find(), Get.find(), Get.find(),
            Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
