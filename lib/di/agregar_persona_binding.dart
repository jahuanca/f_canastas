
import 'package:flutter_canastas/data/repositories/personal_empresa_repository_implementation.dart';
import 'package:flutter_canastas/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_canastas/domain/use_cases/nueva_tarea/get_personal_empresa_by_subdivision_use_case.dart';
import 'package:flutter_canastas/ui/pages/agregar_persona/agregar_persona_controller.dart';
import 'package:get/get.dart';

class AgregarPersonaBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut<PersonalEmpresaRepository>(() => PersonalEmpresaRepositoryImplementation());

    Get.lazyPut<GetPersonalsEmpresaBySubdivisionUseCase>(() => GetPersonalsEmpresaBySubdivisionUseCase(Get.find()));
    
    Get.lazyPut<AgregarPersonaController>(() => AgregarPersonaController(Get.find()));
    
  }

}