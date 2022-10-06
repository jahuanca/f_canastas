import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/ui/pages/encuesta/encuestas/encuestas_controller.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:get/get.dart';

class EncuestasPage extends StatelessWidget {
  final EncuestasController controller = Get.find<EncuestasController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<EncuestasController>(
      init: controller,
      builder: (_) => Scaffold(
        backgroundColor: secondColor,
        body: GetBuilder<EncuestasController>(
          id: 'encuestas',
          builder: (_) => ListView.builder(
            itemCount: _.encuestas.length,
            itemBuilder: (context, index) =>
                _itemActividad(size, context, index),
          ),
        ),
      ),
    );
  }

  Widget _itemActividad(Size size, context, index) {
    return GetBuilder<EncuestasController>(
        id: 'seleccionado',
        builder: (_) => GestureDetector(
              onLongPress: _.seleccionados.length > 0
                  ? null
                  : () => _.seleccionar(index),
              onTap: _.seleccionados.length > 0
                  ? () => _.seleccionar(index)
                  : () => _.goDetalleEncuesta(index),
              child: Container(
                decoration: BoxDecoration(
                  color: (_.seleccionados.contains(index))
                      ? Colors.blue
                      : Colors.transparent,
                  border: (_.seleccionados.contains(index))
                      ? Border.all()
                      : Border.all(color: Colors.transparent),
                ),
                padding: EdgeInsets.all(size.width * 0.05),
                child: Container(
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                      color: cardColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${_.encuestas[index]?.name}: ${formatoFechaExplore(_.encuestas[index].fechaInicio, 0, 0)} - ${formatoFechaExplore(_.encuestas[index].fechaFin, 0, 0)}' ??
                                                '',
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${_.encuestas[index].titulo}' ??
                                                    '',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${_.encuestas[index].tipoEncuesta}' ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ],
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.sms_outlined,
                                                      color: infoColor,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      '${_.encuestas[index].preguntas.length ?? 0}',
                                                      style: TextStyle(
                                                          color: infoColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                flex: 1),
                                            /* if(((_.encuestas[index]?.cantidadTotal ?? 0) != 0)) */
                                            Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.person_outline,
                                                      color: successColor,
                                                    ),
                                                    Text(
                                                      '${_.encuestas[index].cantidadTotal ?? 0}',
                                                      style: TextStyle(
                                                          color: successColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                flex: 1),

                                            /*if((_.encuestas[index]?.hayPendientes ?? false))
                                            Expanded(child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Bounce(
                                                  infinite: false,
                                                  child: Icon(Icons.error , color: alertColor,)),
                                              ],
                                            ), flex: 1),
                                            */
                                          ],
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 12,
                              ),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: primaryColor,
                                        child: IconButton(
                                          onPressed: () =>
                                              _.goSincronizacionMasiva(index),
                                          icon: Icon(Icons.sync,
                                              color: Colors.white),
                                        ),
                                      ),
                                      /* CircleAvatar(                                        
                                        backgroundColor: secondColor,
                                        child: IconButton(
                                          onPressed: ()=> _.goGraficos(index),
                                          icon: Icon(Icons.bar_chart,
                                              color: primaryColor),
                                        ),
                                      ) */
                                    ],
                                  ),
                                  flex: 3),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
