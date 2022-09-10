import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/splash_general/splash_general_controller.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashGeneralPage extends GetWidget<SplashGeneralController> {

  final SplashGeneralController splashController=Get.find<SplashGeneralController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashGeneralController>(
      init: splashController,
      builder: (_)=> SafeArea(
        child: Scaffold(
          backgroundColor: (PreferenciasUsuario().modoDark) ? secondColor : secondColor,
          body: Column(
            children: [
              Flexible(child: Container(), flex: 1),
              Flexible(child: Container(
                child: Row(
                  children: [
                    Flexible(child: Container(), flex: 1,),
                    Flexible(child:
                      Container(
                        child: ImageIcon(
                          AssetImage('assets/common/images/ic_logo.png'),
                          size: 150, 
                        )
                      ), flex: 1,),
                    Flexible(child: Container(), flex: 1,),
                  ],
                ),
              ), flex: 1),
              Flexible(child: Container(), flex: 1)
            ],
          )
        ),
      ),
    );
  }
}