
import 'package:flutter_actividades/di/login_binding.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/splash/get_token_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/login/login_page.dart';
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
      Get.offAndToNamed('navigation');
    }else{
      //Get.offAndToNamed('login');
      //Get.offAndToNamed('selected_app');
      LoginBinding(type: 0).dependencies();
      Get.off( ()=> LoginPage());
    }
  }
}