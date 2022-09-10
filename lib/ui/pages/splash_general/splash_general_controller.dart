
import 'package:flutter_actividades/ui/pages/selected_app/selecter_app_page.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashGeneralController extends GetxController{


  SplashGeneralController();

  @override
  void onInit(){
    super.onInit();
  }

  @override
  void onReady()async{
    super.onReady();
    await Future.delayed(Duration(seconds: 2));
    
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String lastVersion= packageInfo.version;
    PreferenciasUsuario().lastVersion=lastVersion;
    
    Get.off( ()=> SelectedAppPage());
  }
}