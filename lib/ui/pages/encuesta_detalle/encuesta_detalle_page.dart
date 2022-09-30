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
            body: GetBuilder<EncuestaDetalleController>(
              id: 'detalles',
              builder: (_)=> Container(
                child:  _.personalRespondido.length == 0
                  ? _emptyContainer(size)
                  : GetBuilder<EncuestaDetalleController>(
                      builder: (_) => ListView.builder(
                        itemCount: _.personalRespondido.length,
                        itemBuilder: (context, index) =>
                            _itemPersona(size, index),
                      ),
                    ),
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
      id: 'detalle_${index}',
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: GestureDetector(
          onTap: () => _.goEditar(index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: size.width,
            decoration: BoxDecoration(
                color: _.personalRespondido[index]?.estadoLocal == 0
                    ? Colors.white
                    : _.personalRespondido[index]?.estadoLocal == -1 ? alertColor.withAlpha(50) : successColor.withAlpha(50),
                border: Border.all(
                    color: _.personalRespondido[index]?.estadoLocal == 0
                        ? primaryColor
                        : _.personalRespondido[index]?.estadoLocal == -1 ? alertColor : successColor),
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
                            '${_.personalRespondido[index].codigoempresa} - ${_.personalRespondido[index].personal?.nombreCompleto}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              _.personalRespondido[index].getEstadoIcon(),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            
                            children: [

                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${_.personalRespondido[index].respuestas.length}/${_.encuestaSeleccionada.preguntas.length} rtas.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: 
                                    _.personalRespondido[index].respuestas.length < _.encuestaSeleccionada.preguntas.length
                                    ? dangerColor : successColor,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  formatoFechaHora(_.personalRespondido[index].fecha),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
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
                          if (_.personalRespondido[index]?.getPendientesPorMigrar())
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
                                icon: Icon(_.personalRespondido[index]?.estadoLocal == 0
                                    ? Icons.close
                                    : _.personalRespondido[index]?.estadoLocal == -1 ? Icons.close :Icons.delete_outline),
                                color: _.personalRespondido[index]?.estadoLocal == 0
                                    ? Colors.white
                                    : dangerColor),
                            backgroundColor: _.personalRespondido[index]?.estadoLocal == 0
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
                          _.numeroDocumento == null ? Colors.grey : primaryColor,
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
