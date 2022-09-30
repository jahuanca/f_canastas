
import 'package:flutter_actividades/data/repositories/actividad_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/labor_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_empresa_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_vehiculo_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/actividad_repository.dart';
import 'package:flutter_actividades/domain/repositories/labor_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_labors_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_personal_vehiculo_by_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/create_personal_vehiculo_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/delete_personal_vehiculo_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/get_all_personal_vehiculo_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/update_personal_vehiculo_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/vehiculo_temporada/update_vehiculo_temporada_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_personal_vehiculo/listado_personal_vehiculo_controller.dart';
import 'package:get/get.dart';

class ListadoPersonalVehiculoBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut<PersonalEmpresaRepository>(() => PersonalEmpresaRepositoryImplementation());
    Get.lazyPut<PersonalVehiculoRepository>(() => PersonalVehiculoRepositoryImplementation());
    Get.lazyPut<ActividadRepository>(() => ActividadRepositoryImplementation());
    Get.lazyPut<LaborRepository>(() => LaborRepositoryImplementation());

    Get.lazyPut<GetPersonalsEmpresaUseCase>(() => GetPersonalsEmpresaUseCase(Get.find()));
    Get.lazyPut<UpdateVehiculoTemporadaUseCase>(() => UpdateVehiculoTemporadaUseCase(Get.find()));
    Get.lazyPut<GetActividadsUseCase>(() => GetActividadsUseCase(Get.find()));
    Get.lazyPut<GetLaborsUseCase>(() => GetLaborsUseCase(Get.find()));
    Get.lazyPut<GetAllPersonalVehiculoUseCase>(() => GetAllPersonalVehiculoUseCase(Get.find()));
    Get.lazyPut<CreatePersonalVehiculoUseCase>(() => CreatePersonalVehiculoUseCase(Get.find()));
    Get.lazyPut<UpdatePersonalVehiculoUseCase>(() => UpdatePersonalVehiculoUseCase(Get.find()));
    Get.lazyPut<DeletePersonalVehiculoUseCase>(() => DeletePersonalVehiculoUseCase(Get.find()));
    Get.lazyPut<GetPersonalVehiculoByTemporadaUseCase>(() => GetPersonalVehiculoByTemporadaUseCase(Get.find()));

    Get.lazyPut<ListadoPersonalVehiculoController>(() => ListadoPersonalVehiculoController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    
  }

}