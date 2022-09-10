
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/di/listado_vehiculo_temporada_binding.dart';
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';
import 'package:flutter_actividades/domain/sincronizar/get_temporadas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/others/export_data_to_excel_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/temporadas/update_temporada_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_vehiculo_temporada/listado_vehiculo_temporada_page.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';

import 'package:get/get.dart';
import 'package:image_editor_pro/image_editor_pro.dart';

class TemporadasController extends GetxController {
  
  final GetTemporadasUseCase _getTemporadasUseCase;
  final UpdateTemporadaUseCase _updateTemporadaUseCase;
  final ExportDataToExcelUseCase _exportDataToExcelUseCase;

  bool validando = false;

  TemporadasController(
    this._getTemporadasUseCase,
    this._updateTemporadaUseCase,
    this._exportDataToExcelUseCase,
  );

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getTemporadas();
  }

  Future<void> getTemporadas() async {
    temporadas = await _getTemporadasUseCase.execute();
    update(['tareas']);
    return;
  }

  void onChangedMenu(dynamic value, int index) async {
    switch (value.toInt()) {
      case 1:
        break;
      case 2:
        goCopiar(index);
        break;
      case 3:
        goEliminar(index);
        break;
      case 4:
        goExcel(index);
        break;
      default:
        break;
    }
  }

  void goExcel(int index) async {
    await _exportDataToExcelUseCase.execute(temporadas[index]);
  }

  void goAprobar(int index) async {
    String mensaje = await validarParaAprobar(index);
    if (mensaje != null) {
      basicAlert(
        Get.overlayContext,
        'Alerta',
        mensaje,
        'Aceptar',
        () => Get.back(),
      );
    } else {
      basicDialog(
        Get.overlayContext,
        'Alerta',
        '¿Desea aprobar esta actividad?',
        'Si',
        'No',
        () async {
          Get.back();
          await getimageditor(index);
        },
        () => Get.back(),
      );
    }
  }

  Future<void> getimageditor(int index) async {
    Navigator.push(Get.overlayContext, MaterialPageRoute(builder: (context) {
      return ImageEditorPro(
        appBarColor: Color(0xFF009ee0),
        bottomBarColor: Colors.white,
      );
    })).then((geteditimage) async {
      if (geteditimage != null) {
        File _image = geteditimage[0];

        /* temporadas[index].pathUrl = _image.path;
        temporadas[index].estadoLocal = 'A'; */
        /* await _updatePreTareoProcesoUvaUseCase.execute(
            temporadas[index], temporadas[index].key); */
        update(['seleccionado']);
      }
    }).catchError((er) {
      
    });
  }

  Future<String> validarParaAprobar(int index) async {
    /* PreTareoProcesoUvaEntity tarea = temporadas[index]; */
    /* if (tarea.detalles == null || tarea.detalles.isEmpty) {
      return 'No se puede aprobar una actividad que no tiene personal';
    } else {
      for (var item in tarea.detalles) {
        if (!item.validadoParaAprobar) {
          return 'Verifique que todos los datos del personal esten llenos';
        }
      }
    } */
    return null;
  }

  Future<void> goMigrar(int index) async {
    if (temporadas[index].estadoLocal == 'A') {
      basicDialog(
        Get.overlayContext,
        'Alerta',
        '¿Desea migrar esta actividad?',
        'Si',
        'No',
        () async {
          Get.back();
          await migrar(index);
        },
        () => Get.back(),
      );
    } else {
      basicAlert(
        Get.overlayContext,
        'Alerta',
        'Esta tarea aun no ha sido aprobada',
        'Aceptar',
        () => Get.back(),
      );
    }
  }

  Future<void> migrar(int index) async {
    validando = true;
    update(['validando']);
    /* PreTareoProcesoUvaEntity tareaMigrada =
        await _migrarAllPreTareoUvaUseCase.execute(temporadas[index]);
    if (tareaMigrada != null) {
      toastExito('Exito', 'Tarea migrada con exito');
      temporadas[index].estadoLocal = 'M';
      temporadas[index].itempretareaprocesouva =
          tareaMigrada.itempretareaprocesouva;
      await _updatePreTareoProcesoUvaUseCase.execute(
          temporadas[index], temporadas[index].key);
      tareaMigrada = await _uploadFileOfPreTareoUvaUseCase.execute(
          temporadas[index], File(temporadas[index].pathUrl));
      temporadas[index].firmaSupervisor = tareaMigrada?.firmaSupervisor;
      await _updatePreTareoProcesoUvaUseCase.execute(
          temporadas[index], temporadas[index].key);
    } */
    validando = false;
    update(['validando', 'tareas']);
  }

  /* Future<void> goMigrarPreTareo(int index) async {
    await _migrarAllPreTareoUseCase.execute(preTareos[index]);
  } */

  Future<void> goListadoVehiculos(int id) async {
    int index=temporadas.indexWhere((element) => element.id == id);
    List<TemporadaEntity> otras = [];
    /* otras.addAll(temporadas);
    otras.removeAt(index); */
    ListadoVehiculoTemporadaBinding().dependencies();
    final resultado = await Get.to<List<dynamic>>(
        () => ListadoVehiculoTemporadaPage(),
        arguments: {
          'otras': otras,
          'tarea': temporadas[index],
          'index': temporadas[index].id,
        });

    if (resultado != null ) {
      temporadas[index].sizeVehiculos = resultado[0];
      temporadas[index].sizePersonalRegistrados = resultado[1];
      await _updateTemporadaUseCase.execute(
          temporadas[index],);
    }
    update(['tareas']);
  }

  Future<void> delete(int index) async {
    /* await _deletePreTareoProcesoUvaUseCase.execute(temporadas[index].key); */
    temporadas.removeAt(index);
  }

  List<int> seleccionados = [];
  List<TemporadaEntity> temporadas = [];

  void seleccionar(int index) {
    int i = seleccionados.indexWhere((element) => element == index);
    if (i == -1) {
      seleccionados.add(index);
    } else {
      seleccionados.removeAt(i);
    }
    update(['seleccionado']);
  }

  int getPersonalLenght(TemporadaEntity temporada){
    int total=0;
    for (var i = 0; i < (temporada?.sizeVehiculos ?? 0); i++) {
      total=total+(temporada.sizePersonalRegistrados ?? 0);
    }
    return total;
  }


  Future<void> editarTarea(int index) async {
    /* NuevaPreTareaUvaBinding().dependencies();
    final result = await Get.to<PreTareoProcesoUvaEntity>(
        () => NuevaPreTareaUvaPage(),
        arguments: {'tarea': temporadas[index]});
    if (result != null) {
      result.idusuario = PreferenciasUsuario().idUsuario;
      temporadas[index] = result;
      await _updatePreTareoProcesoUvaUseCase.execute(
          temporadas[index], temporadas[index].key);
      update(['tareas']);
    } */
  }

  Future<void> copiarTarea(int index) async {
    /* NuevaPreTareaUvaBinding().dependencies();
    final result = await Get.to<PreTareoProcesoUvaEntity>(
        () => NuevaPreTareaUvaPage(),
        arguments: {'tarea': temporadas[index]});
    if (result != null) {
      result.idusuario = PreferenciasUsuario().idUsuario;
      int id=await _createPreTareoProcesoUvaUseCase.execute(result);
      result.key=id;
      temporadas.add(result);
      update(['tareas']);
    } */
  }

  void goEliminar(int index) {
    basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Esta seguro de eliminar esta tarea?',
      'Si',
      'No',
      () async {
        await delete(index);
        update(['tareas']);
        Get.back();
      },
      () => Get.back(),
    );
  }

  void goCopiar(int index) {
    basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Esta seguro de copiar la siguiente tarea?',
      'Si',
      'No',
      () async {
        Get.back();
        await copiarTarea(index);
      },
      () => Get.back(),
    );
  }

  void goEditar(int index) {
    basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Esta seguro de editar la actividad?',
      'Si',
      'No',
      () async {
        Get.back();
        await editarTarea(index);
      },
      () => Get.back(),
    );
  }
}
