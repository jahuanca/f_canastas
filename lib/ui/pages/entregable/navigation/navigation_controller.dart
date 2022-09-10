import 'package:flutter_actividades/ui/pages/entregable/aprobar/aprobar_page.dart';
import 'package:flutter_actividades/ui/pages/entregable/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/ui/pages/entregable/migrar/migrar_page.dart';
import 'package:flutter_actividades/ui/pages/entregable/search/search_page.dart';
import 'package:flutter_actividades/ui/pages/entregable/temporadas/temporadas_page.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NavigationController extends GetxController {
  NavigationController();

  final List<Widget> lista = [
    HomePage(),
    TemporadasPage(),
    Container(),
    AprobarPage(),
    MigrarPage(),
    Container(),
    Container(),
  ];

  int indexWidget = 0;
  String titulo = 'Inicio';

  List<Widget> actions = [];

  void eventos(int index, GlobalKey<ScaffoldState> scaffoldKey) {
    actions.clear();
    switch (index) {
      case 0:
        titulo = 'Inicio';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      case 1:
        //scaffoldKey.currentState.openDrawer();
        actions.add(IconButton(
            //onPressed: () => Get.to(() => SearchPage()),
            onPressed: showSearch,
            icon: Icon(Icons.search)));
        /* actions.add(IconButton(
            onPressed: Get.find<ListadoVehiculoTemporadaController>().goLectorCode,
            icon: Icon(Icons.qr_code))); */
        titulo = 'Temporadas';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      case 2:
        //scaffoldKey.currentState.openDrawer();
        actions.add(IconButton(
            onPressed: () => Get.to(() => SearchPage()),
            icon: Icon(Icons.search)));
        titulo = 'Aprobación';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      case 3:
        actions.add(IconButton(onPressed: () {}, icon: Icon(Icons.search)));
        titulo = 'Migración';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      case 4:
        actions.add(IconButton(onPressed: () {}, icon: Icon(Icons.search)));
        titulo = 'Arándano';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      case 5:
        actions.add(IconButton(onPressed: () {}, icon: Icon(Icons.search)));
        titulo = 'Packing';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      case 6:
        titulo = 'Esparrago';
        scaffoldKey.currentState.openEndDrawer();
        indexWidget = index;
        update(['bottom_navigation']);
        break;

      default:
        indexWidget = index;
        update(['bottom_navigation']);
        break;
    }
  }

  void showSearch() {
    showMaterialModalBottomSheet(
      context: Get.overlayContext,
      backgroundColor: Colors.black12,
      isDismissible: true,
      builder: (context) => SearchPage(),
    );
  }

  void change() {
    update(['modo']);
  }

  Future<bool> goBack() async {
    return await basicDialog(
      Get.overlayContext,
      'Alerta',
      'Saldra de la aplicación, ¿esta seguro?',
      'Si',
      'No',
      () => Get.back(result: true),
      () => Get.back(result: false),
    );
  }
}
