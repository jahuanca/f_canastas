
import 'package:flutter_canastas/data/repositories/export_data_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/pre_tareo_proceso_uva_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/temporada_repository_implementation.dart';
import 'package:flutter_canastas/domain/repositories/export_data_repository.dart';
import 'package:flutter_canastas/domain/repositories/pre_tareo_proceso_uva_repository.dart';
import 'package:flutter_canastas/domain/repositories/temporada_repository.dart';
import 'package:flutter_canastas/domain/sincronizar/get_temporadas_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/others/export_data_to_excel_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/pre_tareos_uva/create_pre_tareo_proceso_uva_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/pre_tareos_uva/delete_pre_tareo_proceso_uva_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/pre_tareos_uva/migrar_all_pre_tareo_uva_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/pre_tareos_uva/update_pre_tareo_proceso_uva_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/pre_tareos_uva/upload_file_of_pre_tareo_uva_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/temporadas/update_temporada_use_case.dart';
import 'package:flutter_canastas/ui/pages/temporadas/temporadas_controller.dart';
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