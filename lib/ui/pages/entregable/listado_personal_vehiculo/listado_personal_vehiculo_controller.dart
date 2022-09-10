import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_actividades/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_actividades/domain/sincronizar/get_personal_vehiculo_by_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/create_personal_vehiculo_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/delete_personal_vehiculo_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/entregable/personal_vehiculo/get_all_personal_vehiculo_use_case.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/entities/labor_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_actividades/domain/sincronizar/get_labors_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:sunmi_barcode_plugin/sunmi_barcode_plugin.dart';

class ListadoPersonalVehiculoController extends GetxController
    implements ScannerCallBack {
  List<int> seleccionados = [];
  List<PersonalEmpresaEntity> personal = [];
  List<PersonalVehiculoEntity> personalSeleccionado = [];
  List<PersonalVehiculoEntity> enBase = [];
  int idtemporada;
  int key;
  VehiculoTemporadaEntity vehiculoTemporadaSeleccionado;
  List<PersonalVehiculoEntity> detalles;
  List<VehiculoTemporadaEntity> otrosVehiculoTemporada = [];

  List<ActividadEntity> actividades = [];
  List<LaborEntity> labores = [];

  final GetPersonalsEmpresaUseCase _getPersonalsEmpresaUseCase;
  final GetPersonalVehiculoByTemporadaUseCase
      _getPersonalVehiculoByTemporadaUseCase;
  final GetAllPersonalVehiculoUseCase _getAllPersonalVehiculoUseCase;
  final CreatePersonalVehiculoUseCase _createPersonalVehiculoUseCase;
  final DeletePersonalVehiculoUseCase _deletePersonalVehiculoUseCase;
  final GetActividadsUseCase _getActividadsUseCase;
  final GetLaborsUseCase _getLaborsUseCase;
  bool validando = false;
  bool editando = false;
  HoneywellScanner honeywellScannerClasificacion;
  SunmiBarcodePlugin sunmiBarcodePlugin;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ListadoPersonalVehiculoController(
      this._getPersonalsEmpresaUseCase,
      this._getPersonalVehiculoByTemporadaUseCase,
      this._getActividadsUseCase,
      this._getLaborsUseCase,
      this._createPersonalVehiculoUseCase,
      this._getAllPersonalVehiculoUseCase,
      this._deletePersonalVehiculoUseCase,
    );

  @override
  void onInit() async {
    super.onInit();
    actividades = await _getActividadsUseCase.execute();
    labores = await _getLaborsUseCase.execute();

    if (Get.arguments != null) {
      if (Get.arguments['idtemporada'] != null) {
        idtemporada = Get.arguments['idtemporada'] as int;
        await getPersonalVehiculoByTemporada();
      }
      if (Get.arguments['key'] != null) {
        key = Get.arguments['key'] as int;
        print('Key: $key');
        await getPersonalVehiculo();
        update(['personal_seleccionado_pv']);
      }

      

      if (Get.arguments['otras'] != null) {
        otrosVehiculoTemporada =
            Get.arguments['otras'] as List<VehiculoTemporadaEntity>;
      }

      if (Get.arguments['personal'] != null) {
        personal = Get.arguments['personal'] as List<PersonalEmpresaEntity>;
        update(['personal']);
      } else {
        validando = true;
        update(['validando']);
        personal = await _getPersonalsEmpresaUseCase.execute();

        validando = false;
        update(['validando']);
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

  @override
  

  @override
  void onReady()async{
    super.onReady();
  }

  Future<void> getPersonalVehiculo() async {
    personalSeleccionado =
        await _getAllPersonalVehiculoUseCase.execute('$idtemporada-personal_vehiculo_$key');
  }

  Future<void> getPersonalVehiculoByTemporada() async {
    enBase = await _getPersonalVehiculoByTemporadaUseCase.execute(idtemporada);
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
      honeywellScannerClasificacion.stopScanner();
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

    honeywellScannerClasificacion = HoneywellScanner();
    honeywellScannerClasificacion.setScannerCallBack(this);
    honeywellScannerClasificacion.setProperties(properties);
    honeywellScannerClasificacion.startScanner();
  }

  @override
  void onDecoded(String result) {
    setCodeBar(result, true);
  }

  @override
  void onError(Exception error) {
    toastError('Error', error.toString());
  }

  String placa;

  void changePlaca(String value) {
    placa = value;
    update(['placa']);
  }

  Future<void> addVehiculo() async {
    if(placa?.length != 8){
      toastError('Error', 'Dimension minima 8 digitos.');
      return;
    }

    await setCodeBar(placa.toString());
    placa = null;
    Get.back();
  }

  Future<void> _showNotification(bool success, String mensaje) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    false;

    await flutterLocalNotificationsPlugin?.show(
      2,
      success ? 'Exito' : 'Error',
      mensaje,
      platform,
      payload: '',
    );
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
    personalSeleccionado.forEach((e) {
      if (e.hora == null) {
        toastError('Error',
            'Existe un personal con datos vacios. Por favor, ingreselos.');
        return false;
      }
    });
    Get.back(result: personalSeleccionado.length);
    return true;
  }

  Future<void> changeOptionsGlobal(dynamic index) async {
    switch (index) {
      case 1:
        seleccionados.clear();
        for (var i = 0; i < personalSeleccionado.length; i++) {
          seleccionados.add(i);
        }
        update(['seleccionados', 'personal_seleccionado_pv']);
        break;
      case 2:
        seleccionados.clear();
        update(['seleccionados', 'personal_seleccionado_pv']);
        break;
      default:
    }
  }

  Future<void> changeOptions(dynamic index, int position) async {
    switch (index) {
      case 2:
        goEliminar(position);

        break;
      default:
        break;
    }
  }

  void goEliminar(int index) {
    basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Esta eliminar el personal?',
      'Si',
      'No',
      () async {
        Get.back();
        await _deletePersonalVehiculoUseCase.execute(
            '$idtemporada-personal_vehiculo_$key', personalSeleccionado[index].key);
        personalSeleccionado.removeAt(index);
        update(['seleccionados', 'personal_seleccionado_pv', 'listado_v']);
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
      for (var element in otrosVehiculoTemporada) {
        Box<PersonalVehiculoEntity> personalOtra =
            await Hive.openBox('$idtemporada-personal_vehiculo_${element.key}');
        int indexOtra = personalOtra.values.toList().indexWhere((e) =>
            e.personal.nrodocumento.toString().trim() ==
            barcode.toString().trim());
        if (indexOtra != -1) {
          byLector
              ? toastError('Error', 'Se encuentra en otro vehiculo')
              : await _showNotification(false, 'Se encuentra en otro vehiculo');
          buscando = false;
          return;
        }
      }

      int indexEnBase =
          enBase.indexWhere((e) => e.nrodocumento == barcode.toString() && e.idtemporada == idtemporada);
      if (indexEnBase != -1) {
        update(['seleccionados', 'personal_seleccionado_pv', 'listado_v']);
        byLector
            ? toastError('Error', 'Producto ya entregado.')
            : await _showNotification(false, 'Producto ya entregado.');
        buscando = false;
        return;
      }

      int indexEncontrado = personalSeleccionado
          .indexWhere((e) => e.personal.nrodocumento == barcode.toString());
      if (indexEncontrado != -1) {
        update(['seleccionados', 'personal_seleccionado_pv', 'listado_v']);
        byLector
            ? toastError('Error', 'Personal registrado anteriormente.')
            : await _showNotification(
                false, 'Personal registrado anteriormente.');
        buscando = false;
        return;
      }

      int index =
          personal.indexWhere((e) => e.nrodocumento == barcode.toString());

      if (index != -1) {
        if (personal[index].bloqueado) {
          byLector
              ? toastError('Error', 'Personal bloqueado.')
              : await _showNotification(false, 'Personal bloqueado.');
          buscando = false;
          return;
        }
        byLector
            ? toastExito('Éxito', 'Personal registrado.')
            : await _showNotification(true, 'Personal registrado.');

        PersonalVehiculoEntity p = PersonalVehiculoEntity(
          fecha: DateTime.now(),
          hora: DateTime.now(),
          personal: personal[index],
          idpuntoentrega: PreferenciasUsuario().idPuntoEntrega,
          codigosap: personal[index].codigoempresa,
          idusuario: PreferenciasUsuario().idUsuario,
        );

        int keyD=await _createPersonalVehiculoUseCase.execute(
            '$idtemporada-personal_vehiculo_$key', p);
        p.key=keyD;
        personalSeleccionado.insert(0, p);
        update(['seleccionados', 'personal_seleccionado_pv', 'listado_v']);
        buscando = false;
        return;
      } else {
        byLector
            ? toastError('Error', 'Personal no encontrado.')
            : await _showNotification(false, 'Personal no encontrado.');
        buscando = false;
        return;
      }
    }
  }
}
