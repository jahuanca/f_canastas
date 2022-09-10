import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_actividades/domain/sincronizar/get_vehiculos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/vehiculo_temporada/create_vehiculo_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/vehiculo_temporada/delete_vehiculo_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/vehiculo_temporada/get_all_vehiculo_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/vehiculo_temporada/migrar_all_vehiculo_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/vehiculo_temporada/update_vehiculo_temporada_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/listado_personal_vehiculo/listado_personal_vehiculo_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_actividades/di/listado_personal_vehiculo_binding.dart';
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/entities/labor_entity.dart';
import 'package:flutter_actividades/domain/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_actividades/domain/sincronizar/get_labors_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'package:sunmi_barcode_plugin/sunmi_barcode_plugin.dart';
import 'package:uuid/uuid.dart';

class ListadoVehiculoTemporadaController extends GetxController
    implements ScannerCallBack {
  Uuid key = new Uuid();
  List<int> seleccionados = [];
  List<VehiculoEntity> vehiculos = [];
  List<VehiculoTemporadaEntity> vehiculosRegistrados = [];
  int idtemporada;
  List<TemporadaEntity> otrasTemporadas = [];

  List<ActividadEntity> actividades = [];
  List<LaborEntity> labores = [];

  final GetVehiculosUseCase _getVehiculosUseCase;
  final GetAllVehiculoTemporadaUseCase _getAllVehiculoTemporadaUseCase;

  final MigrarAllVehiculoTemporadaUseCase _migrarAllVehiculoTemporadaUseCase;
  final CreateVehiculoTemporadaUseCase _createVehiculoTemporadaUseCase;
  final UpdateVehiculoTemporadaUseCase _updateVehiculoTemporadaUseCase;
  final DeleteVehiculoTemporadaUseCase _deleteVehiculoTemporadaUseCase;
  final GetActividadsUseCase _getActividadsUseCase;
  final GetLaborsUseCase _getLaborsUseCase;
  bool validando = false;
  bool editando = false;
  HoneywellScanner honeywellScanner;
  SunmiBarcodePlugin sunmiBarcodePlugin;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ListadoVehiculoTemporadaController(
      this._createVehiculoTemporadaUseCase,
      this._migrarAllVehiculoTemporadaUseCase,
      this._getAllVehiculoTemporadaUseCase,
      this._deleteVehiculoTemporadaUseCase,
      this._getVehiculosUseCase,
      this._getActividadsUseCase,
      this._getLaborsUseCase,
      this._updateVehiculoTemporadaUseCase);

  @override
  void onInit() async {
    super.onInit();
    actividades = await _getActividadsUseCase.execute();
    vehiculos = await _getVehiculosUseCase.execute();
    labores = await _getLaborsUseCase.execute();
    List<CodeFormat> codeFormats = [];
    codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);
    Map<String, dynamic> properties = {
      ...CodeFormatUtils.getAsPropertiesComplement(codeFormats),
      'DEC_CODABAR_START_STOP_TRANSMIT': true,
      'DEC_EAN13_CHECK_DIGIT_TRANSMIT': true,
    };

    honeywellScanner = HoneywellScanner();
    honeywellScanner.setScannerCallBack(this);
    honeywellScanner.setProperties(properties);
    if (Get.arguments != null) {
      if (Get.arguments['otras'] != null) {
        otrasTemporadas = Get.arguments['otras'] as List<TemporadaEntity>;
      }

      if (Get.arguments['index'] != null) {
        editando = true;
        idtemporada = Get.arguments['index'] as int;
        this.getVehiculos();
        update(['personal_seleccionado_vt']);
      }
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    sunmiBarcodePlugin = SunmiBarcodePlugin();
    if (await sunmiBarcodePlugin.isScannerAvailable()) {
      await initPlatformState();
      sunmiBarcodePlugin
          .onBarcodeScanned()
          .listen((event) => setCodeBar(event, true));
    } else {
      initHoneyWell();
    }
  }

  Future<void> initPlatformState() async {
    try {
      await sunmiBarcodePlugin.getScannerModel();
    } on PlatformException {}
  }

  @override
  void onClose() async {
    super.onClose();
    if (!(await sunmiBarcodePlugin.isScannerAvailable())) {
      honeywellScanner.stopScanner();
    }
  }

  void initHoneyWell() {
    List<CodeFormat> codeFormats = [];
    codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);
    Map<String, dynamic> properties = {
      ...CodeFormatUtils.getAsPropertiesComplement(codeFormats),
      'DEC_CODABAR_START_STOP_TRANSMIT': true,
      'DEC_EAN13_CHECK_DIGIT_TRANSMIT': true,
    };

    honeywellScanner = HoneywellScanner();
    honeywellScanner.setScannerCallBack(this);
    honeywellScanner.setProperties(properties);
    honeywellScanner.startScanner();
  }

  @override
  void onDecoded(String result) {
    setCodeBar(result, true);
  }

  @override
  void onError(Exception error) {
    toastError('Error', error.toString());
  }

  Future<void> getVehiculos() async {
    vehiculosRegistrados = (await _getAllVehiculoTemporadaUseCase
            .execute('vehiculos_temporada_$idtemporada'))
        .reversed
        .toList();
    update(['listado_vt']);
  }

  Future<void> _showNotification(bool success, String mensaje) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    false;

    await flutterLocalNotificationsPlugin.show(
      0,
      success ? 'Exito' : 'Error',
      mensaje,
      platform,
      payload: '',
    );
  }

  void goAprobar(int key) async {
    int index = vehiculosRegistrados.indexWhere((e) => e.key == key);

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

  Future<String> validarParaAprobar(int index) async {
    VehiculoTemporadaEntity tarea = vehiculosRegistrados[index];
    /* if (tarea.sizeDetails == null || tarea.sizeDetails == 0) {
      return 'No se puede aprobar una actividad que no tiene personal';
    } */
    return null;
  }

  Future<void> goMigrar(int key) async {
    int index = vehiculosRegistrados.indexWhere((e) => e.key == key);
    if (vehiculosRegistrados[index].estadoLocal == 'A') {
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
    VehiculoTemporadaEntity vehiculoMigrado =
        await _migrarAllVehiculoTemporadaUseCase.execute(
            'vehiculos_temporada_$idtemporada',
            vehiculosRegistrados[index].key);
    if (vehiculoMigrado != null) {
      toastExito('Exito', 'Tarea migrada con exito');
      vehiculosRegistrados[index].estadoLocal = 'M';
      vehiculosRegistrados[index].id = vehiculoMigrado.id;
      await _updateVehiculoTemporadaUseCase.execute(
          'vehiculos_temporada_$idtemporada',
          vehiculosRegistrados[index],
          vehiculosRegistrados[index].key);
      /* vehiculoMigrado = await _uploadFileOfPreTareoUseCase.execute(
          temporadaSeleccionada.vehiculoTemporadas[index], File(temporadaSeleccionada.vehiculoTemporadas[index].pathUrl)); */
      vehiculosRegistrados[index].firmasupervisor =
          vehiculoMigrado?.firmasupervisor;
      await _updateVehiculoTemporadaUseCase.execute(
          'vehiculos_temporada_$idtemporada',
          vehiculosRegistrados[index],
          vehiculosRegistrados[index].key);
    }
    validando = false;
    update(['validando', 'listado_vt']);
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

        vehiculosRegistrados[index].pathUrl = _image.path;
        vehiculosRegistrados[index].estadoLocal = 'A';
        await _updateVehiculoTemporadaUseCase.execute(
            'vehiculos_temporada_$idtemporada',
            vehiculosRegistrados[index],
            vehiculosRegistrados[index].key);

        update(['seleccionado']);
      }
    }).catchError((er) {});
  }

  Future<dynamic> _onSelectNotification(String json) async {
    return;
  }

  void seleccionar(int index) {
    int i = seleccionados.indexWhere((element) => element == index);
    if (i == -1) {
      seleccionados.add(index);
    } else {
      seleccionados.removeAt(i);
    }
    update(['seleccionado']);
  }

  Future<bool> onWillPop() async {
    vehiculosRegistrados.forEach((e) {
      if (e.hora == null) {
        toastError('Error',
            'Existe un personal con datos vacios. Por favor, ingreselos.');
        return false;
      }
    });
    int total = 0;
    for (var i = 0; i < vehiculosRegistrados.length; i++) {
      total = total + (vehiculosRegistrados[i]?.sizeDetails ?? 0);
    }
    Get.back(result: [vehiculosRegistrados.length, total]);
    return true;
  }

  Future<void> onChangedMenu(dynamic value, int key) async {
    switch (value) {
      case 1:
        goEliminar(key);
        break;
      default:
    }
  }

  Future<void> goListadoDetalles(int key) async {
    int index =
        vehiculosRegistrados.indexWhere((element) => element.key == key);
    List<VehiculoTemporadaEntity> otras = [];
    otras.addAll(vehiculosRegistrados);
    otras.removeAt(index);
    if (await sunmiBarcodePlugin.isScannerAvailable()) {
      sunmiBarcodePlugin.stop();
    }
    ListadoPersonalVehiculoBinding().dependencies();
    final resultados =
        await Get.to<int>(() => ListadoPersonalVehiculoPage(), arguments: {
      'otras': otras,
      'idtemporada': idtemporada,
      'key': vehiculosRegistrados[index].key,
    });
    sunmiBarcodePlugin = new SunmiBarcodePlugin();
    if (await sunmiBarcodePlugin.isScannerAvailable()) {
      await initPlatformState();
      sunmiBarcodePlugin
          .onBarcodeScanned()
          .listen((event) => setCodeBar(event, true));
    }
    if (resultados != null) {
      vehiculosRegistrados[index].sizeDetails = resultados;
      await _updateVehiculoTemporadaUseCase.execute(
          'vehiculos_temporada_$idtemporada',
          vehiculosRegistrados[index],
          vehiculosRegistrados[index].key);
      update(['item_$index']);
    }
  }

  Future<void> changeOptionsGlobal(dynamic index) async {
    switch (index) {
      case 1:
        seleccionados.clear();
        for (var i = 0; i < vehiculosRegistrados.length; i++) {
          seleccionados.add(i);
        }
        update(['seleccionados', 'personal_seleccionado_vt']);
        break;
      case 2:
        seleccionados.clear();
        update(['seleccionados', 'personal_seleccionado_vt']);
        break;
      default:
    }
  }

  Future<void> changeOptions(dynamic index, int key) async {
    switch (index) {
      case 2:
        goEliminar(key);

        break;
      default:
        break;
    }
  }

  void goEliminar(int key) {
    basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Esta eliminar la caja?',
      'Si',
      'No',
      () async {
        Get.back();
        vehiculosRegistrados.removeWhere((e) => e.key == key);
        await _deleteVehiculoTemporadaUseCase.execute(
            'vehiculos_temporada_$idtemporada', key);
        update(['seleccionados', 'personal_seleccionado_vt']);
      },
      () => Get.back(),
    );
  }

  void goLectorCode() {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancelar", false, ScanMode.DEFAULT)
        .listen((barcode) async {
      await setCodeBar(barcode);
    });
  }

  bool buscando = false;

  Future<void> setCodeBar(dynamic barcode, [bool byLector = false]) async {
    if (barcode != null && barcode != '-1' && buscando == false) {
      buscando = true;
      int index =
          vehiculos.indexWhere((e) => e.placa.toString() == barcode.toString());
      if (index != -1) {
        byLector
            ? toastExito('Éxito', 'Vehículo registrado.')
            : await _showNotification(true, 'Vehículo registrado.');

        VehiculoTemporadaEntity v = VehiculoTemporadaEntity(
          fecha: DateTime.now(),
          hora: DateTime.now(),
          placa: vehiculos[index].placa,
          idvehiculo: vehiculos[index].id,
          idtemporada: idtemporada,
          personal: [],
          idusuario: PreferenciasUsuario().idUsuario,
        );

        int key = await _createVehiculoTemporadaUseCase.execute(
            'vehiculos_temporada_$idtemporada', v);
        v.key = key;
        vehiculosRegistrados.insert(0, v);
        update(['personal_seleccionado_vt']);
        buscando = false;
      } else {
        byLector
            ? toastError('Error', 'Vehículo no encontrado.')
            : await _showNotification(false, 'Vehículo no encontrado.');
        buscando = false;
      }
    }
  }

  String placa;

  void changePlaca(String value) {
    placa = value;
    update(['placa']);
  }

  Future<void> addVehiculo() async {
    int index = vehiculos.indexWhere((e) => e.placa.toString() == placa.trim());
    if (index == -1) {
      await _showNotification(true, 'Vehículo no registrado.');
      return;
    }

    VehiculoTemporadaEntity v = VehiculoTemporadaEntity(
      fecha: DateTime.now(),
      hora: DateTime.now(),
      placa: placa,
      idvehiculo: null,
      idtemporada: idtemporada,
      personal: [],
      idusuario: PreferenciasUsuario().idUsuario,
    );

    int key = await _createVehiculoTemporadaUseCase.execute(
        'vehiculos_temporada_$idtemporada', v);
    v.key = key;
    vehiculosRegistrados.insert(0, v);
    update(['personal_seleccionado_vt']);
    placa = null;
    Get.back();
  }

  Future<void> editarPlaca(int key) async {
    int indexV =
        vehiculos.indexWhere((e) => e.placa.toString() == placa.trim());
    if (indexV == -1) {
      await _showNotification(true, 'Vehículo no registrado.');
      return;
    }

    int index =
        vehiculosRegistrados.indexWhere((element) => element.key == key);
    VehiculoTemporadaEntity v = vehiculosRegistrados[index];
    v.placa = placa.toString().trim();

    await _updateVehiculoTemporadaUseCase.execute(
        'vehiculos_temporada_$idtemporada', v, key);
    update(['personal_seleccionado_vt']);
    vehiculosRegistrados[index] = v;
    Get.back();
  }
}
