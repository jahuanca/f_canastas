import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_tarea_proceso_entity.dart';
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/entities/tarea_proceso_entity.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_personal_empresa_by_subdivision_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter_actividades/ui/utils/validators_utils.dart';
import 'package:get/get.dart';

class AgregarPersonaController extends GetxController {
  GetPersonalsEmpresaBySubdivisionUseCase
      _getPersonalsEmpresaBySubdivisionUseCase;
  int cantidadEnviada = 0;
  List<PersonalEmpresaEntity> personalEmpresa = [];
  List<PersonalTareaProcesoEntity> personalSeleccionado = [];
  bool validando = false;
  bool actualizando = false;

  TareaProcesoEntity tareaSeleccionada;

  PersonalEmpresaEntity personaSeleccionada;
  PersonalTareaProcesoEntity personalTareaProcesoEntity =
      new PersonalTareaProcesoEntity();

  String errorHoraInicio,
      errorHoraFin,
      errorPausaInicio,
      errorPausaFin,
      errorPersonal,
      errorCantidadHoras,
      errorCantidadRendimiento,
      errorCantidadAvance;

  String textoCantidadHoras='---Sin calcular---';

  AgregarPersonaController(this._getPersonalsEmpresaBySubdivisionUseCase);

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['tarea'] != null) {
        tareaSeleccionada = Get.arguments['tarea'] as TareaProcesoEntity;
        personalTareaProcesoEntity.turno = tareaSeleccionada.turnotareo;
        personalTareaProcesoEntity.esjornal = tareaSeleccionada.esjornal;
        personalTareaProcesoEntity.esrendimiento =
            tareaSeleccionada.esrendimiento;
        personalTareaProcesoEntity.diasiguiente =
            tareaSeleccionada.diasiguiente;
        personalTareaProcesoEntity.horainicio = tareaSeleccionada.horainicio;
        personalTareaProcesoEntity.horafin = tareaSeleccionada.horafin;
        personalTareaProcesoEntity.pausainicio = tareaSeleccionada.pausainicio;
        personalTareaProcesoEntity.pausafin = tareaSeleccionada.pausafin;
        calcularCantidadHoras();
        update([
          'hora_inicio',
          'hora_fin',
          'pausa_inicio',
          'pausa_fin',
          'turno',
          'dia_siguiente',
          'rendimiento'
        ]);
      }
      if (Get.arguments['cantidad'] != null) {
        cantidadEnviada = Get.arguments['cantidad'] as int;
        actualizando = true;
      }

      if (Get.arguments['personal_seleccionado'] != null) {
        personalSeleccionado = Get.arguments['personal_seleccionado']
            as List<PersonalTareaProcesoEntity>;
      }

      if (Get.arguments['personal'] != null) {
        personalEmpresa =
            Get.arguments['personal'] as List<PersonalEmpresaEntity>;
        if (personalEmpresa.length > 0) {
          personaSeleccionada = personalEmpresa.first;
          personalTareaProcesoEntity.personal = personaSeleccionada;
          changePersonal(personaSeleccionada.codigoempresa);
        }
      } else {
        if (Get.arguments['sede'] != null) {
          validando = true;
          update(['validando']);
          personalEmpresa =
              await _getPersonalsEmpresaBySubdivisionUseCase.execute(
                  (Get.arguments['sede'] as SubdivisionEntity).idsubdivision);
          if (personalEmpresa.length > 0) {
            personaSeleccionada = personalEmpresa.first;
            personalTareaProcesoEntity.personal = personaSeleccionada;
          }
          validando = false;
        }
      }
    }

    update(['personal', 'validando']);
  }

  Future<void> changePersonal(String id) async {
    personaSeleccionada =
        personalEmpresa.firstWhere((e) => e.codigoempresa == id);
    int index = personalSeleccionado.indexWhere((e) => e.codigoempresa == id);
    if (index != -1) {
      personalTareaProcesoEntity.personal = personaSeleccionada;
      personalTareaProcesoEntity.personal.codigoempresa =
          personaSeleccionada.codigoempresa;
      mostrarDialog('Personal ya registrado');
      errorPersonal = 'Personal ya se encuentra registrado.';
    } else {
      errorPersonal = null;
      personalTareaProcesoEntity.personal = personaSeleccionada;
      personalTareaProcesoEntity.personal.codigoempresa =
          personaSeleccionada.codigoempresa;
    }
    update(['personal']);
  }

  void deleteInicioPausa() {
    personalTareaProcesoEntity.pausainicio = null;
    update(['inicio_pausa']);
  }

  void deleteFinPausa() {
    personalTareaProcesoEntity.pausafin = null;
    update(['fin_pausa']);
  }

  void guardar() {
    String mensaje = validar();
    if (mensaje != null) {
      toastError('Error', mensaje);
      return;
    }
    if (actualizando) {
      List<PersonalTareaProcesoEntity> personalRespuesta = [];
      for (final p in personalEmpresa) {
        personalRespuesta.add(PersonalTareaProcesoEntity(
          personal: p,
          codigoempresa: p.codigoempresa,
          idusuario: PreferenciasUsuario().idUsuario,
          horainicio: personalTareaProcesoEntity.horainicio,
          horafin: personalTareaProcesoEntity.horafin,
          pausainicio: personalTareaProcesoEntity.pausainicio,
          pausafin: personalTareaProcesoEntity.pausafin,
          cantidadHoras: personalTareaProcesoEntity.cantidadHoras,
          cantidadavance: personalTareaProcesoEntity.cantidadavance,
          cantidadrendimiento: personalTareaProcesoEntity.cantidadrendimiento,
        ));
      }
      Get.back(result: personalRespuesta);
      return;
    }

    if (personalTareaProcesoEntity.personal == null) {
      toastError('Error', 'No existe persona seleccionada');
      return;
    }
    personalTareaProcesoEntity.codigoempresa =
        personalTareaProcesoEntity.personal.codigoempresa;
    personalTareaProcesoEntity.idusuario = PreferenciasUsuario().idUsuario;
    Get.back(result: personalTareaProcesoEntity);
  }

  Future<void> changeRendimiento(bool value) async {
    if (value) {
      personalTareaProcesoEntity.esjornal = true;
      personalTareaProcesoEntity.esrendimiento = false;
      errorCantidadRendimiento=null;
    } else {
      personalTareaProcesoEntity.esjornal = false;
      personalTareaProcesoEntity.esrendimiento = true;
    }
    update(['rendimiento', 'actividades', 'cantidad_rendimiento']);
  }

  Future<void> changeDiaSiguiente(bool value) async {
    personalTareaProcesoEntity.diasiguiente = value;
    update(['dia_siguiente']);
  }

  void changeTurno(String value) {
    personalTareaProcesoEntity.turno = value;
    update(['turno']);
  }

  void changeCantidadRendimiento(String value) {
    errorCantidadRendimiento = validatorUtilText(
        value,
        'Rendmiento',
        personalTareaProcesoEntity.esrendimiento
            ? {
                'required': '',
              }
            : null);

    if (errorCantidadRendimiento != null) {
      update(['cantidad_rendimiento']);
      return;
    }

    double rendimiento = double.tryParse(value);
    if (rendimiento != null) {
      personalTareaProcesoEntity.cantidadrendimiento = rendimiento;
      errorCantidadRendimiento = null;
    } else {
      if([null, ''].contains(value) && personalTareaProcesoEntity.esrendimiento){
        errorCantidadRendimiento=null;
        personalTareaProcesoEntity.cantidadrendimiento=null;
      }else{
        errorCantidadRendimiento = 'El valor ingresado no es un número';
      }
    }

    update(['cantidad_rendimiento']);
  }

  void changeCantidadAvance(String value) {
    if([null, ''].contains(value)){
      errorCantidadAvance=null;
      update(['cantidad_avance']);
      return;
    }
    double avance = double.tryParse(value);
    if (avance != null) {
      personalTareaProcesoEntity.cantidadavance = avance;
      errorCantidadAvance = null;
    } else {
      errorCantidadAvance = 'El valor ingresado no es un número';
    }

    update(['cantidad_avance']);
  }

  void calcularCantidadHoras() {
    int cantidadHoras;
    int cantidadMinutos;
    if (personalTareaProcesoEntity.horainicio == null ||
        personalTareaProcesoEntity.horafin == null) {
      return;
    }
    DateTime hInicio = personalTareaProcesoEntity.horainicio;
    DateTime hFin = personalTareaProcesoEntity.horafin;

    if (hFin.isBefore(hInicio)) {
      hFin.add(Duration(days: 1));
    }

    cantidadMinutos = hFin.difference(hInicio).inMinutes;
    if (personalTareaProcesoEntity.pausainicio != null &&
        personalTareaProcesoEntity.pausafin != null) {
      DateTime pInicio = personalTareaProcesoEntity.pausainicio;
      DateTime pFin = personalTareaProcesoEntity.pausafin;

      if (pFin.isBefore(pInicio)) {
        pFin.add(Duration(days: 1));
      }

      cantidadMinutos -=pFin.difference(pInicio).inMinutes;
      
    }
    
    personalTareaProcesoEntity.cantidadHoras=cantidadMinutos/60;
    cantidadHoras= (cantidadMinutos / 60).truncate();
    cantidadMinutos= cantidadMinutos % 60;

    
    textoCantidadHoras='$cantidadHoras h $cantidadMinutos min';
    update(['cantidad_horas']);
  }

  void changeHoraInicio() {
    errorHoraInicio = (personalTareaProcesoEntity.horainicio == null)
        ? 'Debe elegir una hora de inicio'
        : null;
    calcularCantidadHoras();
    update(['hora_inicio', 'inicio_pausa', 'fin_pausa']);
  }

  void changeHoraFin() {
    errorHoraFin = (personalTareaProcesoEntity.horafin == null)
        ? 'Debe elegir una hora de fin'
        : null;
    calcularCantidadHoras();
    update(['hora_fin', 'inicio_pausa', 'fin_pausa']);
  }

  void changeInicioPausa() {
    /* if (personalTareaProcesoEntity.pausainicio != null) {
      if (personalTareaProcesoEntity.pausainicio
              .isBefore(personalTareaProcesoEntity.horainicio) ||
          personalTareaProcesoEntity.pausainicio
              .isAfter(personalTareaProcesoEntity.horafin)) {
        mostrarDialog(
            'La hora seleccionada no se encuentra en el rango de inicio y fin');
        personalTareaProcesoEntity.pausainicio = null;
      }
      update(['inicio_pausa']);
    } */
    update(['inicio_pausa']);
    calcularCantidadHoras();
  }

  void changeFinPausa() {
    /* if (personalTareaProcesoEntity.pausafin != null) {
      if (personalTareaProcesoEntity.pausafin
              .isBefore(personalTareaProcesoEntity.horainicio) ||
          personalTareaProcesoEntity.pausafin
              .isAfter(personalTareaProcesoEntity.horafin)) {
        mostrarDialog(
            'La hora seleccionada no se encuentra en el rango de inicio y fin');
        personalTareaProcesoEntity.pausafin = null;
      }
      if (personalTareaProcesoEntity.pausainicio != null &&
          personalTareaProcesoEntity.pausafin
              .isAfter(personalTareaProcesoEntity.pausainicio)) {
        mostrarDialog('La hora debe ser mayor a la hora de pausa');
        personalTareaProcesoEntity.pausafin = null;
      }
      update(['fin_pausa']);
    } */
    update(['fin_pausa']);
    calcularCantidadHoras();
  }

  void mostrarDialog(String mensaje) {
    basicAlert(
      Get.overlayContext,
      'Alerta',
      mensaje,
      'Aceptar',
      () => Get.back(),
    );
  }

  String validar() {
    changeHoraInicio();
    changeHoraFin();
    changePersonal(personaSeleccionada.codigoempresa);
    changeCantidadRendimiento(personalTareaProcesoEntity.cantidadrendimiento.toString());

    if (errorPersonal != null) return errorPersonal;
    if (errorHoraInicio != null) return errorHoraInicio;
    if (errorHoraFin != null) return errorHoraFin;

    if (personalTareaProcesoEntity.pausainicio != null &&
        personalTareaProcesoEntity.pausafin == null) {
      errorPausaFin = 'Debe ingresar la hora de fin de pausa';
      return errorPausaFin;
    }
    errorPausaFin = null;
    if (personalTareaProcesoEntity.pausafin != null &&
        personalTareaProcesoEntity.pausainicio == null) {
      errorPausaInicio = 'Debe ingresar la hora de inicio de pausa';
      return errorPausaInicio;
    }
    errorPausaInicio = null;

    return null;
  }
}
