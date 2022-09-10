import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/ui/pages/encuesta/elegir_opciones/elegir_opciones_controller.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/input_label_widget.dart';
import 'package:get/get.dart';

class ElegirOpcionesPage extends StatelessWidget {
  final ElegirOpcionesController controller =
      Get.find<ElegirOpcionesController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ElegirOpcionesController>(
      id: 'encuesta',
      builder: (_) => Scaffold(
        floatingActionButton: _.editable
            ? FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: _.goGuardar,
                child: Icon(Icons.check),
              )
            : Container(),
        appBar: getAppBarChoose(
            '${_.personalSeleccionado?.codigoempresa} - ${_.personalSeleccionado?.nombreCompleto}',
            [],
            true,
            1.0,
            Alignment.centerLeft,
            18),
        body: SafeArea(
          child: ListView(
            children: [
              //_personal(_.personalSeleccionado, size),
              _titulo(_.encuestaSeleccionada.titulo, size),
              _descripcion(_.encuestaSeleccionada.descripcion, size),
              _tipo(_.encuestaSeleccionada.tipoEncuesta, size),
              _opcionesColumn(size, _.opciones),
              /* _opcionManual(), */
            ],
          ),
        ),
      ),
    );
  }

  Widget _opcionManual() {
    return GetBuilder<ElegirOpcionesController>(
      id: 'opciones',
      builder: (_) => _.opcionElegida?.id == -1
          ? Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 15),
              child: InputLabelWidget(
                /* label: 'Detalle', */
                onChanged: _.changeOpcionManual,
                initialValue: _.opcionManual,
                maxLength: 100,
                hintText: 'Describa su respuesta',
                isTextArea: true,
              ),
            )
          : Container(),
    );
  }

  Widget _titulo(String titulo, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      /* height: size.height * 0.1, */
      alignment: Alignment.centerLeft,
      child: Text(
        titulo ?? 'Sin titulo',
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _descripcion(String descripcion, Size size) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        descripcion ?? 'Sin descripción',
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
    );
  }

  Widget _tipo(String tipo, Size size) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        tipo ?? 'Sin descripción',
        style: TextStyle(fontSize: 14, color: Colors.black45),
      ),
    );
  }

  Widget _opcionesColumn(Size size, List<EncuestaOpcionesEntity> opciones) {
    List<Widget> children = [];

    for (int i = 0; i < opciones.length; i++) {
      children.add(_itemOpcion(size, i));
    }

    return Column(children: children);
  }

  Widget _itemOpcion(Size size, int index) {
    return GetBuilder<ElegirOpcionesController>(
      id: 'opciones',
      builder: (_) => GestureDetector(
        onTap: _.editable ? () => _.changeOption(index) : null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: _.opcionElegida == null
                        ? secondColor
                        : _.opcionElegida.id == _.opciones[index].id
                            ? primaryColor
                            : secondColor)),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Opacity(
                        opacity: _.opcionElegida == null
                            ? 0
                            : _.opcionElegida.id == _.opciones[index].id
                                ? 1
                                : 0,
                        child: Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(_.opciones[index].opcion),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _.opciones[index].descripcion ?? '',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      flex: 4,
                    ),
                  ],
                ),
                if (_.opcionElegida?.id == -1 &&
                    _.opciones[index].id == _.opcionElegida?.id)
                  _opcionManual()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
