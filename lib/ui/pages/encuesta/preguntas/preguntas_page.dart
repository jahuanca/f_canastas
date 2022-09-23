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
        floatingActionButton: FloatingActionButton(onPressed: _.goReturn,
          backgroundColor: primaryColor,
          child: Icon(Icons.check, color: Colors.white,),
        ),
        appBar: getAppBarChoose(_.personalSeleccionado.nombreCompleto ?? '', [],
            true, 1, Alignment.centerLeft, 20),
        body: ListView.builder(
          itemCount: _.encuestaSeleccionada.preguntas.length,
          itemBuilder: (context, index) =>
              Container(child: _itemPregunta(index)),
        ),
      ),
    );
  }

  Widget _itemPregunta(int index) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
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
                    _itemBorrar(index),
                    _itemPreguntas(
                        index, _.encuestaSeleccionada.preguntas[index].opciones)
                  ],
                )),
      ),
    );
  }

  Widget _itemBorrar(int index){
    return GetBuilder<PreguntasController>(
      id: 'pregunta_$index',
      builder: (_)=> _.encuestaSeleccionada.preguntas[index].indexSelected != null ? Container(
          padding: EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            
            onPressed: ()=> _.changeSelected(index, null), 
            child: Text('Borrar respuesta')),
        ): Container());
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
        onTap: () => _.changeSelected(index, e.id),
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
                        e.id ==
                                    _.encuestaSeleccionada.preguntas[index]
                                        .indexSelected ??
                                false
                            ? Icons.circle
                            : Icons.circle_outlined,
                        color: e.id ==
                                    _.encuestaSeleccionada.preguntas[index]
                                        .indexSelected ??
                                false
                            ? primaryColor
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
                          fontWeight: e.id ==
                                      _.encuestaSeleccionada.preguntas[index]
                                          .indexSelected ??
                                  false
                              ? FontWeight.w500
                              : FontWeight.w400,
                          color: e.id ==
                                      _.encuestaSeleccionada.preguntas[index]
                                          .indexSelected ??
                                  false
                              ? primaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (e.id == -1 &&
                _.encuestaSeleccionada.preguntas[index].indexSelected == e.id)
              _opcionManual(index, e.id),
          ],
        ),
      ),
    );
  }

  Widget _opcionManual(int indexPregunta, int indexOpcion) {
    return GetBuilder<PreguntasController>(
      
      builder: (_)=> Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: InputLabelWidget(
          textSize: 14,
          onChanged: (value)=> _.onChangeOpcionManual(indexPregunta, value),
          hintText: 'Ingrese su respuesta'),
      ),
    );
  }
}
