import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_campos_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_etapas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_turnos_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_unidad_negocios_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';

class InformacionEncuestadoController extends GetxController {
  UnidadNegocioEntity unidadNegocioSelected;
  EncuestaEtapaEntity encuestaEtapaSelected;
  EncuestaCampoEntity encuestaCampoSelected;
  EncuestaTurnoEntity encuestaTurnoSelected;

  List<UnidadNegocioEntity> unidadesNegocio = [];
  List<EncuestaEtapaEntity> encuestaEtapas = [];
  List<EncuestaCampoEntity> encuestaCampos = [];
  List<EncuestaTurnoEntity> encuestaTurnos = [];

  GetUnidadNegociosUseCase _getUnidadNegociosUseCase;
  GetEncuestaEtapasUseCase _getEncuestaEtapasUseCase;
  GetEncuestaCamposByValuesUseCase _getEncuestaCamposByValuesUseCase;
  GetEncuestaTurnosByValuesUseCase _getEncuestaTurnosByValuesUseCase;

  bool validando = false;
  bool editando = false;
  RespuestaEntity informacion;

  InformacionEncuestadoController(
    this._getUnidadNegociosUseCase,
    this._getEncuestaEtapasUseCase,
    this._getEncuestaCamposByValuesUseCase,
    this._getEncuestaTurnosByValuesUseCase,
  );

  @override
  void onInit() {
    if (Get.arguments != null) {
      if(Get.arguments['informacion'] != null){
        informacion=RespuestaEntity.fromJson((Get.arguments['informacion'] as RespuestaEntity).toJson());
        editando = true;
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    validando = true;
    update(['validando']);

    await getUnidadesNegocio();
    await getEtapas();

    validando = false;
    editando = false;
    update(['validando']);
  }

  Future<void> getUnidadesNegocio() async {
    unidadesNegocio = await _getUnidadNegociosUseCase.execute();
    if (unidadesNegocio.length > 0) {
      await changeUnidadNegocio(editando
          ? informacion?.idunidad.toString()
          : PreferenciasUsuario()?.idUnidadNegocio?.toString() ?? unidadesNegocio.first.idunidad.toString());
    }
    update(['unidad_negocio']);
  }

  Future<void> getEtapas() async {
    encuestaEtapas = await _getEncuestaEtapasUseCase.execute();
    if (encuestaEtapas.length > 0) {
      encuestaEtapaSelected = encuestaEtapas.first;
      await changeEtapa(editando
          ? informacion.idetapa?.toString()
          : PreferenciasUsuario()?.idEtapa?.toString() ?? encuestaEtapaSelected.idetapa.toString());
    }
    update(['encuesta_etapa']);
  }

  Future<void> getCamposByValue(int idEtapa) async {
    encuestaCampos = await _getEncuestaCamposByValuesUseCase.execute({
      'idetapa': idEtapa,
    })..sort((a, b) => a.campo.compareTo(b.campo));
    if (encuestaCampos.length > 0) {
      encuestaCampoSelected = encuestaCampos.first;
      await changeCampo(editando
          ? informacion.idcampo?.toString()
          : PreferenciasUsuario()?.idCampo?.toString() ?? encuestaCampoSelected.idcampo.toString());
    }
    update(['encuesta_campo']);
  }

  Future<void> getTurnosByValue(int idCampo) async {
    encuestaTurnos = await _getEncuestaTurnosByValuesUseCase.execute({
      'idcampo': idCampo,
    })..sort((a, b) => a.turno.compareTo(b.turno));

    if (encuestaTurnos.length > 0) {
      print('tiene valores');
      encuestaTurnoSelected = encuestaTurnos.first;
      await changeTurno(editando
          ? informacion.idturno?.toString()
          : PreferenciasUsuario()?.idTurno?.toString() ?? encuestaTurnoSelected.idturno.toString());
    }
    update(['encuesta_turno']);
  }

  Future<void> changeUnidadNegocio(String id) async {
    int index = unidadesNegocio.indexWhere((e) => e.idunidad == int.parse(id));
    if (index != -1) {
      unidadNegocioSelected = unidadesNegocio[index];
    }
  }

  Future<void> changeEtapa(String id) async {
    print(id);
    int index = encuestaEtapas.indexWhere((e) => e.idetapa == int.parse(id));
    if (index != -1) {
      encuestaEtapaSelected = encuestaEtapas[index];
      await getCamposByValue(encuestaEtapaSelected?.idetapa);
    }
  }

  Future<void> changeCampo(String id) async {
    int index = encuestaCampos.indexWhere((e) => e.idcampo == int.parse(id));
    if (index != -1) {
      encuestaCampoSelected = encuestaCampos[index];
      await getTurnosByValue(encuestaCampoSelected.idcampo);
    }
  }

  Future<void> changeTurno(String id) async {
    int index = encuestaTurnos.indexWhere((e) => e.idturno == int.parse(id));
    if (index != -1) {
      encuestaTurnoSelected = encuestaTurnos[index];
    }
  }

  Future<void> setInformacion() async {
    bool result = await basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Desea guardar esta información?',
      'Si',
      'No',
      () async {
        Get.back(result: true);
      },
      () => Get.back(result: false),
    );

    if (result ?? false) {
      PreferenciasUsuario().idUnidadNegocio= unidadNegocioSelected.idunidad;
      PreferenciasUsuario().idEtapa= encuestaEtapaSelected.idetapa;
      PreferenciasUsuario().idCampo= encuestaCampoSelected.idcampo;
      PreferenciasUsuario().idTurno=encuestaTurnoSelected.idturno;

      Get.back(
          result: RespuestaEntity(
        idunidad: unidadNegocioSelected.idunidad,
        idetapa: encuestaEtapaSelected.idetapa,
        idcampo: encuestaCampoSelected.idcampo,
        idturno: encuestaTurnoSelected.idturno,
      ));
    }
  }
}
