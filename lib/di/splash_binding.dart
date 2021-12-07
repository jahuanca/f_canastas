
import 'package:flutter_canastas/data/repositories/storage_repository_implementation.dart';
import 'package:flutter_canastas/domain/repositories/storage_repository.dart';
import 'package:flutter_canastas/domain/use_cases/splash/get_token_use_case.dart';
import 'package:flutter_canastas/ui/pages/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings{

  @override
  void dependencies() {
    
    Get.lazyPut<StorageRepository>(() => StorageRepositoryImplementation());

    Get.lazyPut<GetTokenUseCase>(() => GetTokenUseCase(Get.find()));


    Get.lazyPut<SplashController>(() => SplashController(Get.find()));
    
  }

}