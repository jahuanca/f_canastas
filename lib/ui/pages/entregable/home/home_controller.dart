import 'package:flutter_actividades/di/sincronizar_binding.dart';
import 'package:flutter_actividades/ui/pages/entregable/sincronizar/sincronizar_page.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String lastVersion = 'X.X.X';
  String lastVersionDate = '----';
  int modo = 0;
  HomeController();

  @override
  void onInit() {
    super.onInit();
    PreferenciasUsuario().offLine = true;
    setLog();
  }

  @override
  void onReady() {
    super.onReady();
    
  }

  void setLog(){
    lastVersion = PreferenciasUsuario().lastVersion;
    lastVersionDate = PreferenciasUsuario().lastVersionDate;
    modo = (PreferenciasUsuario().offLine) ? 0 : 1;
    update(['version', 'modo']);
  }

  void changeModo(dynamic value) {
    modo = value;
    update(['modo', 'refresh']);
  }

  void setModo() {
    PreferenciasUsuario().offLine = (modo == 0) ? true : false;
  }

  Future<void> goSincronizar() async{
    SincronizarBinding().dependencies();
    await Get.to(()=> SincronizarPage());
    setLog();
  }
}
