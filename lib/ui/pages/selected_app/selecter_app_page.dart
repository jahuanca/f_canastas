import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/ui/pages/selected_app/selected_app_controller.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_actividades/core/entregable/colors.dart'
    as colorEntregable;
import 'package:flutter_actividades/core/encuesta/colors.dart' as colorEncuesta;

class SelectedAppPage extends GetWidget<SelectedAppController>{

  final SelectedAppController controller=Get.find<SelectedAppController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<SelectedAppController>(
      init: controller,
      builder: (_) => Scaffold(
        appBar: getAppBarChoose('Listado de aplicaciones', [], true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _itemCard(size, 'Entregables', colorEntregable.primaryColor,'assets/common/gifs/entregable.json', _.goEntregable),
            _itemCard(size, 'Encuestas', colorEncuesta.primaryColor,
                'assets/common/gifs/check_list.json', _.goEncuesta),
          ],
        ),
      ),
    );
  }

  _itemCard(Size size, String titulo, Color color, String pathImage, void Function() onTap) {
    return FadeInRight(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        height: size.height * 0.18,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(borderRadius),
          shadowColor: color,
          child: GetBuilder<SelectedAppController>(
            builder: (_) => GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: color, width: 2),
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          titulo.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            color: color,
                          ),
                        ),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                        child: Container(
                          child: Lottie.asset(pathImage)), flex: 1),
                    Expanded(child: Container(), flex: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
