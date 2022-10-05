import 'dart:developer';

import 'package:flutter_actividades/di/informacion_encuestado_binding.dart';
import 'package:flutter_actividades/domain/entities/detalle_respuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/entities/pregunta_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_campos_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_etapas_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_turnos_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_unidad_negocios_by_values_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/informacion_encuestado/informacion_encuestado_page.dart';
import 'package:get/get.dart';

class PreguntasController extends GetxController {
  EncuestaEntity encuestaSeleccionada;
  PersonalEmpresaEntity personalSeleccionado;
  PersonalRespuestasEntity personalRespuestaAnterior;
  RespuestaEntity informacion;
  bool validando = false;
  int pendientes=0;
  int respondidas=0;

  GetUnidadNegociosByValuesUseCase _getUnidadNegociosByValuesUseCase;
  GetEncuestaEtapasByValuesUseCase _getEncuestaEtapasByValuesUseCase;
  GetEncuestaCamposByValuesUseCase _getEncuestaCamposByValuesUseCase;
  GetEncuestaTurnosByValuesUseCase _getEncuestaTurnosByValuesUseCase;

  UnidadNegocioEntity unidadNegocioEntity;
  EncuestaEtapaEntity encuestaEtapaEntity;
  EncuestaCampoEntity encuestaCampoEntity;
  EncuestaTurnoEntity encuestaTurnoEntity;

  PreguntasController(
    this._getEncuestaCamposByValuesUseCase,
    this._getEncuestaEtapasByValuesUseCase,
    this._getEncuestaTurnosByValuesUseCase,
    this._getUnidadNegociosByValuesUseCase,
  );

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['encuesta'] != null) {
        
        encuestaSeleccionada = EncuestaEntity.fromJson(
            (Get.arguments['encuesta'] as EncuestaEntity).toJson());
      }

      if (Get.arguments['informacion'] != null) {
        informacion = RespuestaEntity.fromJson(
            (Get.arguments['informacion'] as RespuestaEntity).toJson());
      }

      if (Get.arguments['personal_seleccionado'] != null) {
        personalSeleccionado =
            Get.arguments['personal_seleccionado'] as PersonalEmpresaEntity;
      }
      
      if (Get.arguments['detalle'] != null) {
        personalRespuestaAnterior = PersonalRespuestasEntity.fromJson(
            (Get.arguments['detalle'] as PersonalRespuestasEntity).toJson());

        personalRespuestaAnterior.respuestas.forEach((respuesta) {
          int indexRespuesta = encuestaSeleccionada.preguntas
              .indexWhere((e) => e.id == respuesta.idpregunta);
          if (indexRespuesta != -1) {
            respondidas++;
            PreguntaEntity preguntaSeleccionada=encuestaSeleccionada.preguntas[indexRespuesta];
            preguntaSeleccionada.indexesSelected=[];
            preguntaSeleccionada.idRespuestaDB=respuesta.id;
            respuesta.detalles.forEach((detalle) {
              preguntaSeleccionada.indexesSelected.add(detalle.idopcion);
              preguntaSeleccionada.opcionManual =detalle.opcionmanual;
            });
          }else{
            pendientes++;
          }
        log(encuestaSeleccionada.toJson()['Pregunta'].toString());
        });
      }
    }
    super.onInit();
  }

  Future<void> goInformacion() async {
    InformacionEncuestadoBinding().dependencies();
    final result = await Get.to<RespuestaEntity>(
        () => InformacionEncuestadoPage(),
        arguments: {'informacion': informacion});
    if (result != null) {
      informacion = result;
      await getInformacion();
    }
  }

  @override
  onReady() async {
    super.onReady();
    await getInformacion();
  }

  Future<void> getInformacion() async {
    unidadNegocioEntity = (await _getUnidadNegociosByValuesUseCase
            .execute({'idunidad': informacion.idunidad}))
        .first;
    encuestaEtapaEntity = (await _getEncuestaEtapasByValuesUseCase
            .execute({'idetapa': informacion.idetapa}))
        .first;
    encuestaCampoEntity = (await _getEncuestaCamposByValuesUseCase
            .execute({'idcampo': informacion.idcampo}))
        .first;
    encuestaTurnoEntity = (await _getEncuestaTurnosByValuesUseCase
            .execute({'idturno': informacion.idturno}))
        .first;
    update(['informacion']);
  }

  void goReturn() {
    validando = true;
    update(['validando']);
    List<RespuestaEntity> respuestas = [];

    encuestaSeleccionada.preguntas.forEach((pregunta) {
      if (!([null,0].contains(pregunta.indexesSelected?.length))) {
        RespuestaEntity respuesta = new RespuestaEntity(
          idunidad: informacion?.idunidad,
          idetapa: informacion?.idetapa,
          idcampo: informacion?.idcampo,
          idturno: informacion?.idturno,
          personal: personalSeleccionado,
          codigoempresa: personalSeleccionado.codigoempresa,
          estadoLocal: 0,
          fecha: DateTime.now(),
          hora: DateTime.now(),
          detalles: [],
          id: pregunta.idRespuestaDB,
          idpregunta: pregunta.id,
        );


        pregunta.indexesSelected.forEach((indexSelected) {
          DetalleRespuestaEntity detalle = new DetalleRespuestaEntity(
          fecha: DateTime.now(),
          hora: DateTime.now(),
          estadoLocal: 0,
          idopcion: indexSelected,
          opcionmanual: pregunta.opcionManual,
        );

        respuesta.detalles.add(detalle);
        });
        respuestas.add(respuesta);
      }
    });

    validando = false;
    update(['validando']);

    Get.back(
        result: PersonalRespuestasEntity(
      respuestas: respuestas,
      key: personalRespuestaAnterior?.key ?? null,
      idunidad: informacion?.idunidad,
      idetapa: informacion?.idetapa,
      idcampo: informacion?.idcampo,
      idturno: informacion?.idturno,
      idencuesta: encuestaSeleccionada.id,
      codigoempresa: personalSeleccionado.codigoempresa,
      personal: personalSeleccionado,
      fecha: DateTime.now(),
      hora: DateTime.now(),
      estadoLocal: personalRespuestaAnterior?.estadoLocal ?? 0,
    ));
  }

  void changeSelected(int indexPregunta, int indexOpcion) {
    print('Pregunta $indexPregunta, opcion: $indexOpcion');
    PreguntaEntity preguntaSeleccionada=encuestaSeleccionada.preguntas[indexPregunta];

    if(indexOpcion == null){
      preguntaSeleccionada.indexesSelected.clear();
      update(['pregunta_${indexPregunta}']);
      return;
    }
    int index=preguntaSeleccionada.indexesSelected.indexWhere((e) => e == indexOpcion);
    if(preguntaSeleccionada.idtipopregunta == 2){
    //if(true){
      if(index == -1){
        preguntaSeleccionada.indexesSelected.add(indexOpcion);
      }
      else{
        preguntaSeleccionada.indexesSelected?.removeAt(index);
      }
    }else{
      preguntaSeleccionada.indexesSelected.clear();
      preguntaSeleccionada.indexesSelected.add(indexOpcion);
    }

    update(['pregunta_${indexPregunta}']);
  }

  void onChangeOpcionManual(int indexPregunta, String value) {
    encuestaSeleccionada.preguntas[indexPregunta].opcionManual = value;
    update(['pregunta_${indexPregunta}']);
  }
}
