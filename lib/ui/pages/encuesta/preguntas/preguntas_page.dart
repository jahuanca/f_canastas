import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/domain/entities/opcion_entity.dart';
import 'package:flutter_actividades/ui/pages/encuesta/preguntas/preguntas_controller.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/app_bar_widget.dart';
import 'package:flutter_actividades/ui/widgets/encuesta/input_label_widget.dart';
import 'package:get/get.dart';

class PreguntasPage extends StatelessWidget {
  final PreguntasController controller = Get.find<PreguntasController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreguntasController>(
      init: controller,
      builder: (_) => Scaffold(
        backgroundColor: secondColor,
        floatingActionButton: FloatingActionButton(
          onPressed: _.goReturn,
          backgroundColor: primaryColor,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        appBar: getAppBarChoose(_.personalSeleccionado.nombreCompleto ?? '', [],
            true, 1, Alignment.centerLeft, 20),
        body: ListView.builder(
          itemCount: _.encuestaSeleccionada.preguntas.length + 2,
          itemBuilder: (context, index) => (index == 0)
              ? _contador()
              : (index==1) ? informacionEncuestador()
              : Container(child: _itemPregunta(index - 2)),
        ),
      ),
    );
  }

  Widget informacionEncuestador() {
    return GetBuilder<PreguntasController>(
      id: 'informacion',
      builder: (_) => GestureDetector(
        onTap: _.goInformacion,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
                color: cardColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'Información',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'U. negocio',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        flex: 1),
                    Expanded(
                        child: Container(
                          child: Text(_.unidadNegocioEntity?.descripcion ?? ''),
                        ),
                        flex: 2),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text('Etapa',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        flex: 1),
                    Expanded(
                        child: Container(
                          child: Text(
                            _.encuestaEtapaEntity?.descripcion ?? '',
                          ),
                        ),
                        flex: 2),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'Campo',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        flex: 1),
                    Expanded(
                        child: Container(
                          child: Text(_.encuestaCampoEntity?.descripcion ?? ''),
                        ),
                        flex: 2),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text('Turno', 
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        flex: 1),
                    Expanded(
                        child: Container(
                          child: Text(_.encuestaTurnoEntity?.descripcion ?? ''),
                        ),
                        flex: 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemPregunta(int index) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: (controller.encuestaSeleccionada.preguntas[index]?.idRespuestaDB != null)
                  ? successColor
                  : primaryColor
                  ,
                  ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
        ),
        child: GetBuilder<PreguntasController>(
            id: 'pregunta_$index',
            builder: (_) => Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Text(
                                _.encuestaSeleccionada.preguntas[index]
                                    .pregunta,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_.encuestaSeleccionada.preguntas[index]?.idRespuestaDB == null)
                      _itemBorrar(index),
                    _itemPreguntas(
                        index, _.encuestaSeleccionada.preguntas[index].opciones)
                  ],
                )),
      ),
    );
  }

  Widget _contador(){
    return Container(
      child: Row(
        children: [
          Expanded(child: _itemContador("Total:", controller.encuestaSeleccionada.preguntas.length ?? 0 ,Icons.inbox, infoColor), flex: 1,),
          Expanded(child: _itemContador("Respondidos:", controller.respondidas ?? 0 ,Icons.check, successColor), flex: 1,),
          Expanded(child: _itemContador("Pendientes:", controller.pendientes ?? 0 ,Icons.close, alertColor), flex: 1,),
        ],
      ),
    );
  }

  Widget _itemContador(String texto, int valor, IconData icon, Color color){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: CircleAvatar(
            radius: 10,
            backgroundColor: color,
            child: Icon(icon, size: 15, color: Colors.white,)), flex: 1),
          Expanded(child: Row(
            children: [
              Text(texto, style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),),

              Text('  $valor', style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black87
              ),),

            ],
          ), flex: 3),
        ],
      ),
    );
  }


  Widget _itemBorrar(int index) {
    return GetBuilder<PreguntasController>(
        id: 'pregunta_$index',
        builder: (_) =>
            _.encuestaSeleccionada.preguntas[index].indexesSelected.length > 0
                ? Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: (_.encuestaSeleccionada.preguntas[index]?.idRespuestaDB != null)
                            ? null
                            : () => _.changeSelected(index, null)
                            ,
                        child: Text('Borrar respuesta')),
                  )
                : Container());
  }

  Widget _itemPreguntas(int index, List<OpcionEntity> opciones) {
    List<Widget> children = [];

    for (var i = 0; i < opciones.length; i++) {
      OpcionEntity e = opciones[i];
      children.add(_itemOpcion(e, index));
    }

    if (!controller
            .encuestaSeleccionada.preguntas[index].permitirOpcionManual ??
        false) {
      children.add(_itemOpcion(
          OpcionEntity(
            id: -1,
            opcion: 'Otra',
          ),
          index));
    }

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _itemOpcion(OpcionEntity e, int index) {
    return GetBuilder<PreguntasController>(
      builder: (_) => GestureDetector(
        onTap: (_.encuestaSeleccionada.preguntas[index]?.idRespuestaDB != null)
            ? null
            : () => _.changeSelected(index, e.id)
            ,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        _.encuestaSeleccionada.preguntas[index].indexesSelected.contains(e.id) ??
                                false
                            ? Icons.circle
                            : Icons.circle_outlined,
                        color: _.encuestaSeleccionada.preguntas[index].indexesSelected.contains(e.id) ??
                                false
                            ? (controller.encuestaSeleccionada.preguntas[index]?.idRespuestaDB != null)
                                ? successColor
                                : primaryColor
                            : Colors.black38,
                        size: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.opcion,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: _.encuestaSeleccionada.preguntas[index].indexesSelected.contains(e.id)  ??
                                  false
                              ? FontWeight.w500
                              : FontWeight.w400,
                          color: _.encuestaSeleccionada.preguntas[index].indexesSelected.contains(e.id) ??
                                  false
                              ? (controller.encuestaSeleccionada.preguntas[index]?.idRespuestaDB != null)
                                  ? successColor
                                  : primaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (e.id == -1 &&
                _.encuestaSeleccionada.preguntas[index].indexesSelected.contains(e.id))
              _opcionManual(index, e.id),
          ],
        ),
      ),
    );
  }

  Widget _opcionManual(int indexPregunta, int indexOpcion) {
    return GetBuilder<PreguntasController>(
      builder: (_) => Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: InputLabelWidget(
            textSize: 14,
            onChanged:
                (_.encuestaSeleccionada.preguntas[indexPregunta]?.idRespuestaDB != null)
                    ? null
                    : (value) => _.onChangeOpcionManual(indexPregunta, value),
            initialValue:
                _.encuestaSeleccionada.preguntas[indexPregunta].opcionManual ??
                    '',
            hintText: 'Ingrese su respuesta'),
      ),
    );
  }
}
