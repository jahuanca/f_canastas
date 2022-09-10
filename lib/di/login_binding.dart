

import 'package:flutter_actividades/data/repositories/auth_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/punto_entrega_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/entregable/storage_repository_implementation.dart' as entregableSRI;
import 'package:flutter_actividades/data/repositories/encuesta/storage_repository_implementation.dart' as encuestaSRI;
import 'package:flutter_actividades/data/repositories/subdivision_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/auth_repository.dart';
import 'package:flutter_actividades/domain/repositories/punto_entrega_repository.dart';
import 'package:flutter_actividades/domain/repositories/entregable/storage_repository.dart' as entregableSR;
import 'package:flutter_actividades/domain/repositories/encuesta/storage_repository.dart' as encuestaSR;
import 'package:flutter_actividades/domain/repositories/subdivision_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/login/save_token_use_case.dart' as encuestaST;
import 'package:flutter_actividades/domain/use_cases/encuesta/login/save_user_use_case.dart' as encuestaSU;
import 'package:flutter_actividades/domain/use_cases/encuesta/login/sign_in_use_case.dart' as encuestaSI;
import 'package:flutter_actividades/domain/use_cases/entregable/login/save_token_use_case.dart' as entregableST;
import 'package:flutter_actividades/domain/use_cases/entregable/login/save_user_use_case.dart' as entregableSU;
import 'package:flutter_actividades/domain/use_cases/entregable/login/sign_in_use_case.dart' as entregableSI;
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_punto_entregas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/login/login_controller.dart' as lEncuesta;
import 'package:flutter_actividades/ui/pages/entregable/login/login_controller.dart' as lEntregable;
import 'package:get/get.dart';

class LoginBinding extends Bindings{

  int type;

  LoginBinding({this.type=0});


  @override
  void dependencies() {

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImplementation());
    
    Get.lazyPut<SubdivisionRepository>(() => SubdivisionRepositoryImplementation());
    Get.lazyPut<PuntoEntregaRepository>(() => PuntoEntregaRepositoryImplementation());

    
    Get.lazyPut<GetPuntoEntregasUseCase>(() => GetPuntoEntregasUseCase(Get.find()));
    Get.lazyReplace<GetSubdivisonsUseCase>(() => GetSubdivisonsUseCase(Get.find()));


    switch (type) {
      case 0:

        Get.lazyPut<entregableSR.StorageRepository>(() => entregableSRI.StorageRepositoryImplementation());

        Get.lazyReplace<entregableSI.SignInUseCase>(() => entregableSI.SignInUseCase(Get.find()));
        Get.lazyReplace<entregableST.SaveTokenUseCase>(() => entregableST.SaveTokenUseCase(Get.find()));
        Get.lazyReplace<entregableSU.SaveUserUseCase>(() => entregableSU.SaveUserUseCase(Get.find()));

        Get.lazyPut<lEntregable.LoginController>(() => lEntregable.LoginController(Get.find(), Get.find(), Get.find(), Get.find()));
        break;
      case 1:
        Get.lazyPut<encuestaSR.StorageRepository>(() => encuestaSRI.StorageRepositoryImplementation());

        Get.lazyReplace<encuestaSI.SignInUseCase>(() => encuestaSI.SignInUseCase(Get.find()));
        Get.lazyReplace<encuestaST.SaveTokenUseCase>(() => encuestaST.SaveTokenUseCase(Get.find()));
        Get.lazyReplace<encuestaSU.SaveUserUseCase>(() => encuestaSU.SaveUserUseCase(Get.find()));

        Get.lazyPut<lEncuesta.LoginController>(() => lEncuesta.LoginController(Get.find(), Get.find(), Get.find(), Get.find()));
        break;
      default:
    }
  }

}