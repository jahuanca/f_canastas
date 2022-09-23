
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:get/get.dart';

class PreguntasController extends GetxController{

  EncuestaEntity encuestaSeleccionada;
  PersonalEmpresaEntity personalSeleccionado;
  PersonalEncuestaEntity detalle;

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments['encuesta'] != null){
        encuestaSeleccionada= Get.arguments['encuesta']  as EncuestaEntity;
      }

      if(Get.arguments['personal_seleccionado'] != null){
        personalSeleccionado= Get.arguments['personal_seleccionado']  as PersonalEmpresaEntity;
      }

      if(Get.arguments['detalle'] != null){
        detalle= Get.arguments['detalle']  as PersonalEncuestaEntity;
        detalle.respuestas.forEach((respuesta) {
          int indexR=encuestaSeleccionada.preguntas.indexWhere((e) => e.id == respuesta.idpregunta );
          if(indexR != -1){
            encuestaSeleccionada.preguntas[indexR].indexSelected=respuesta.idopcion;
          }
        });
      }
    }
    super.onInit();
  }

  void goReturn(){
    List<RespuestaEntity> respuestas=[];
    encuestaSeleccionada.preguntas.forEach((e) {
      if(e.indexSelected != null)
      respuestas.add(
        RespuestaEntity(
          codigoempresa: personalSeleccionado.codigoempresa,
          idencuesta: encuestaSeleccionada.id,
          idpregunta: e.id,
          idopcion: e.indexSelected,
          opcionmanual: e.opcionManual,
          fecha: DateTime.now(),
          hora: DateTime.now(),
        )
      );
    });

    Get.back(
      result: PersonalEncuestaEntity(
        personal: personalSeleccionado,
        codigoempresa: personalSeleccionado.codigoempresa,
        estadoLocal: 0,
        fecha: DateTime.now(),
        idencuesta: encuestaSeleccionada.id,
        respuestas: respuestas
      )
    );
  }

  void changeSelected(int indexPregunta, int indexOpcion){
    print('Pregunta $indexPregunta, opcion: $indexOpcion');
    encuestaSeleccionada.preguntas[indexPregunta].indexSelected=indexOpcion;
    update(['pregunta_${indexPregunta}']);
  }

  void onChangeOpcionManual(int indexPregunta, String value){
    encuestaSeleccionada.preguntas[indexPregunta].opcionManual=value;
    update(['pregunta_${indexPregunta}']);
  }


}