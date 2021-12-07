

import 'package:flutter_canastas/data/repositories/auth_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/punto_entrega_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/storage_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/subdivision_repository_implementation.dart';
import 'package:flutter_canastas/domain/repositories/auth_repository.dart';
import 'package:flutter_canastas/domain/repositories/punto_entrega_repository.dart';
import 'package:flutter_canastas/domain/repositories/storage_repository.dart';
import 'package:flutter_canastas/domain/repositories/subdivision_repository.dart';
import 'package:flutter_canastas/domain/use_cases/login/save_token_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/login/save_user_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/login/sign_in_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_canastas/ui/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImplementation());
    Get.lazyPut<StorageRepository>(() => StorageRepositoryImplementation());
    Get.lazyPut<SubdivisionRepository>(() => SubdivisionRepositoryImplementation());
    Get.lazyPut<PuntoEntregaRepository>(() => PuntoEntregaRepositoryImplementation());

    Get.lazyReplace<SignInUseCase>(() => SignInUseCase(Get.find()));
    Get.lazyReplace<SaveTokenUseCase>(() => SaveTokenUseCase(Get.find()));
    Get.lazyReplace<SaveUserUseCase>(() => SaveUserUseCase(Get.find()));
    Get.lazyReplace<GetSubdivisonsUseCase>(() => GetSubdivisonsUseCase(Get.find()));

    Get.lazyPut<LoginController>(() => LoginController(Get.find(), Get.find(), Get.find(), Get.find()));
  }

}