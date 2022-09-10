
import 'package:flutter_actividades/data/repositories/entregable/storage_repository_implementation.dart' as entregableSRI;
import 'package:flutter_actividades/data/repositories/encuesta/storage_repository_implementation.dart' as encuestaSRI;
import 'package:flutter_actividades/domain/repositories/encuesta/storage_repository.dart' as encuestaSR;
import 'package:flutter_actividades/domain/repositories/entregable/storage_repository.dart' as entregableSR;
import 'package:flutter_actividades/domain/use_cases/entregable/splash/get_token_use_case.dart' as entregableGT;
import 'package:flutter_actividades/domain/use_cases/encuesta/splash/get_token_use_case.dart' as encuestaGT;
import 'package:flutter_actividades/ui/pages/selected_app/selected_app_controller.dart';
import 'package:flutter_actividades/ui/pages/entregable/splash/splash_controller.dart' as entregableSC;
import 'package:flutter_actividades/ui/pages/encuesta/splash/splash_controller.dart' as encuestaSC;
import 'package:flutter_actividades/ui/pages/splash_general/splash_general_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings{

  int type;

  SplashBinding({this.type=0});

  @override
  void dependencies() {

    
    Get.lazyPut<SelectedAppController>(() => SelectedAppController());


    switch (type) {
      case 0:
        Get.lazyPut<entregableSR.StorageRepository>(() => entregableSRI.StorageRepositoryImplementation());

        Get.lazyPut<entregableGT.GetTokenUseCase>(() => entregableGT.GetTokenUseCase(Get.find()));

        Get.lazyReplace<entregableSC.SplashController>(() => entregableSC.SplashController(Get.find()));   
        break;
      case 1:
        Get.lazyPut<encuestaSR.StorageRepository>(() => encuestaSRI.StorageRepositoryImplementation());

        Get.lazyPut<encuestaGT.GetTokenUseCase>(() => encuestaGT.GetTokenUseCase(Get.find()));

        Get.lazyReplace<encuestaSC.SplashController>(() => encuestaSC.SplashController(Get.find()));
        break;
      default:
        Get.lazyReplace<SplashGeneralController>(() => SplashGeneralController());
        break;
    }

    
    /* Get.lazyReplace<entregableSC.SplashController>(() => entregableSC.SplashController(Get.find()));   
    Get.lazyReplace<encuestaSC.SplashController>(() => encuestaSC.SplashController(Get.find()), tag: 'encuestaSC'); */
    
  }

}