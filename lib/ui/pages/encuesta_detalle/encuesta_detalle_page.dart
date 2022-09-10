import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/ui/pages/encuesta_detalle/encuesta_detalle_controller.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
import 'package:get/get.dart';

class EncuestaDetallePage extends StatelessWidget {
  final EncuestaDetalleController controller =
      Get.find<EncuestaDetalleController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<EncuestaDetalleController>(
      init: controller,
      id: 'encuesta',
      builder: (_) => Stack(
        children: [
          Scaffold(
            appBar: getAppBarChoose(
                _.encuestaSeleccionada.titulo ?? 'Titulo',
                [
                  IconButton(
                      onPressed: () => _.goLectorCode(),
                      icon: Icon(Icons.qr_code)),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                    onPressed: () => dialog(context, size),
                  )
                ],
                true,
                1.0,
                Alignment.centerLeft,
                18),
            body: _.detalles.length == 0
                ? _emptyContainer(size)
                : GetBuilder<EncuestaDetalleController>(
                    id: 'detalles',
                    builder: (_) => ListView.builder(
                      itemCount: _.detalles.length,
                      itemBuilder: (context, index) =>
                          _itemPersona(size, index),
                    ),
                  ),
          ),
          GetBuilder<EncuestaDetalleController>(
            id: 'validando',
            builder: (_) => _.validando
                ? Container(
                    color: Colors.black45,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _itemPersona(Size size, int index) {
    return GetBuilder<EncuestaDetalleController>(
      id: 'detalles',
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: GestureDetector(
          onTap: () => _.goEditar(index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: size.width,
            decoration: BoxDecoration(
                color: _.detalles[index]?.estadoLocal == 0
                    ? Colors.white
                    : _.detalles[index]?.estadoLocal == -1 ? alertColor.withAlpha(50) : successColor.withAlpha(50),
                border: Border.all(
                    color: _.detalles[index]?.estadoLocal == 0
                        ? primaryColor
                        : _.detalles[index]?.estadoLocal == -1 ? alertColor : successColor),
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '${_.detalles[index].codigoempresa} - ${_.detalles[index].personal.nombreCompleto}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${_.detalles[index].opcionEncuesta.opcion}',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            formatoFechaHora(_.detalles[index].hora),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 10),
                Expanded(child: Container(), flex: 1),
                Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if ([-1,0].contains(_.detalles[index]?.estadoLocal))
                            CircleAvatar(
                              child: IconButton(
                                  onPressed: () => _.goSincronizar(index),
                                  icon: Icon(Icons.sync),
                                  color: Colors.white),
                              backgroundColor: successColor,
                            ),
                          CircleAvatar(
                            child: IconButton(
                                onPressed: () => _.goEliminar(index),
                                icon: Icon(_.detalles[index]?.estadoLocal == 0
                                    ? Icons.close
                                    : _.detalles[index]?.estadoLocal == -1 ? Icons.close :Icons.delete_outline),
                                color: _.detalles[index]?.estadoLocal == 0
                                    ? Colors.white
                                    : dangerColor),
                            backgroundColor: _.detalles[index]?.estadoLocal == 0
                                ? dangerColor
                                : Colors.white,
                          ),
                        ],
                      ),
                    ),
                    flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyContainer(Size size) {
    return Container(
      alignment: Alignment.center,
      child: Text('Escanee un codigo QR.'),
    );
  }

  Future<void> dialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Número de documento'),
              actions: [
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.1,
                  child: GetBuilder<EncuestaDetalleController>(
                    id: 'numero_documento',
                    builder: (_) => CircleAvatar(
                      backgroundColor:
                          _.numeroDocumento == null ? Colors.grey : infoColor,
                      child: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        onPressed: [null, ''].contains(_.numeroDocumento)
                            ? null
                            : () async => await _.searchNumeroDocumento(),
                      ),
                    ),
                  ),
                ),
              ],
              content: GetBuilder<EncuestaDetalleController>(builder: (_) {
                _.changeNumeroDocumento(null);
                return TextField(
                  onChanged: _.changeNumeroDocumento,
                  /* maxLength: 11, */
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Digite el documento"),
                );
              }),
            ));
  }
}
