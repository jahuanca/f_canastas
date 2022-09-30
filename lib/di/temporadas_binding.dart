
import 'package:flutter_actividades/data/repositories/export_data_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/pre_tareo_proceso_uva_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/temporada_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/export_data_repository.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_uva_repository.dart';
import 'package:flutter_actividades/domain/repositories/temporada_repository.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_temporadas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/others/export_data_to_excel_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/temporadas/update_temporada_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/temporadas/temporadas_controller.dart';
import 'package:get/get.dart';

class TemporadasBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut<PreTareoProcesoUvaRepository>(() => PreTareoProcesoUvaRepositoryImplementation());
    Get.lazyPut<ExportDataRepository>(() => ExportDataRepositoryImplementation());
    Get.lazyPut<TemporadaRepository>(() => TemporadaRepositoryImplementation());

    Get.lazyReplace<GetTemporadasUseCase>(() => GetTemporadasUseCase(Get.find()));
    Get.lazyReplace<UpdateTemporadaUseCase>(() => UpdateTemporadaUseCase(Get.find()));
    Get.lazyReplace<ExportDataToExcelUseCase>(() => ExportDataToExcelUseCase(Get.find()));

    Get.lazyPut<TemporadasController>(() => TemporadasController(Get.find(), Get.find(), Get.find()));
    
  }

}