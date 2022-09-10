
import 'package:flutter_actividades/di/login_binding.dart';
import 'package:flutter_actividades/di/navigation_binding.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/splash/get_token_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/login/login_page.dart';
import 'package:flutter_actividades/ui/pages/encuesta/navigation/navigation_page.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController{

  GetTokenUseCase _getTokenUseCase;

  SplashController(this._getTokenUseCase);

  @override
  void onInit(){
    super.onInit();
  }

  @override
  void onReady()async{
    super.onReady();
    await Future.delayed(Duration(seconds: 2));
    String token=await _getTokenUseCase.execute();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String lastVersion= packageInfo.version;
    PreferenciasUsuario().lastVersion=lastVersion;
    if(token!=null){
      //Get.offAndToNamed('navigation');
      NavigationBinding(type: 1).dependencies();
      Get.off(()=> NavigationPage());
    }else{
      //Get.offAndToNamed('login');
      //Get.offAndToNamed('selected_app');
      LoginBinding(type: 1).dependencies();
      Get.off( ()=> LoginPage());
    }
  }
}