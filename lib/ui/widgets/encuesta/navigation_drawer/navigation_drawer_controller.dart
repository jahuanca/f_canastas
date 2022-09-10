

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/data/repositories/encuesta/storage_repository_implementation.dart';
import 'package:flutter_actividades/di/aprobar_binding.dart';
import 'package:flutter_actividades/di/encuestas_binding.dart';
import 'package:flutter_actividades/di/home_binding.dart';
import 'package:flutter_actividades/di/listado_personal_vehiculo_binding.dart';
import 'package:flutter_actividades/di/migrar_binding.dart';
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';
import 'package:flutter_actividades/ui/pages/encuesta/login/login_page.dart';
import 'package:flutter_actividades/ui/pages/encuesta/navigation/navigation_controller.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/di/login_binding.dart';
import 'package:get/get.dart';

class NavigationDrawerController extends GetxController{

  UsuarioEntity usuarioEntity;
  

  NavigationDrawerController();

  @override
  void onInit() async{
    super.onInit();
    usuarioEntity=await StorageRepositoryImplementation().getUser();
    update(['usuario']);
  }


  void goConfiguracion(){
    /* Get.to(()=> ConfiguracionPage()); */
  }

  void goFavoritos(){
    /* FavoritosBinding().dependencies();
    Get.to(()=> FavoritosPage()); */
  }

  void goTareas(GlobalKey<ScaffoldState> scaffoldKey){
    ListadoPersonalVehiculoBinding().dependencies();
    Get.find<NavigationController>().eventos(1, scaffoldKey);
  }

  void goMigrar(GlobalKey<ScaffoldState> scaffoldKey){
    MigrarBinding().dependencies();
    Get.find<NavigationController>().eventos(3, scaffoldKey);
  }

  void goEsparragos(GlobalKey<ScaffoldState> scaffoldKey){
    Get.find<NavigationController>().eventos(6, scaffoldKey);
  }

  void goEncuestas(GlobalKey<ScaffoldState> scaffoldKey){
    EncuestasBinding().dependencies();
    Get.find<NavigationController>().eventos(1, scaffoldKey);
  }

  void goAprobar(GlobalKey<ScaffoldState> scaffoldKey){
    AprobarBinding().dependencies();
    Get.find<NavigationController>().eventos(2, scaffoldKey);
  }

  void goHome(GlobalKey<ScaffoldState> scaffoldKey){
    HomeBinding(type: 1).dependencies();
    Get.find<NavigationController>().eventos(0, scaffoldKey);
  }

  void goMisEventos(){
    /* MisEventosBinding().dependencies();
    Get.to(()=> MisEventosPage()); */
  }


  void cerrarSesion(){

    basicDialog(
      Get.overlayContext, 
      'Alerta', 
      '¿Esta seguro de cerrar sesión?', 
      'Si', 
      'No', 
      (){
        Get.back();
        StorageRepositoryImplementation().clearAllData(); 
        LoginBinding(type: 1).dependencies();
        Get.offAll(()=> LoginPage());
      }, 
      ()=> Get.back(),
    );
  }

  void goProfile(){
    /* ProfileBinding().dependencies();
    Get.to(()=> ProfilePage()); */
  }
}