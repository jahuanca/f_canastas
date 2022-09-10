import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/ui/pages/encuesta/splash/splash_controller.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends GetWidget<SplashController> {

  final SplashController splashController=Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: splashController,
      builder: (_)=> SafeArea(
        child: Scaffold(
          backgroundColor: (PreferenciasUsuario().modoDark) ? cardColorDark : cardColor,
          body: Column(
            children: [
              Flexible(child: Container(), flex: 1),
              Flexible(child: Container(
                child: Row(
                  children: [
                    Flexible(child: Container(), flex: 1,),
                    Flexible(child: 
                      Container(
                        child: Container(
                          child: Lottie.asset('assets/common/gifs/check_list.json'),
                          width: 150, 
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