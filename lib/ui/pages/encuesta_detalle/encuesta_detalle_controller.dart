
import 'package:flutter_actividades/di/elegir_opciones_binding.dart';
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/create_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/delete_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/get_all_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/migrar_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/update_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_by_values_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/elegir_opciones/elegir_opciones_page.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class EncuestaDetalleController extends GetxController {
  final GetPersonalsEmpresaUseCase _getPersonalsEmpresaUseCase;
  final GetAllEncuestaOpcionesByValuesUseCase
      _getAllEncuestaOpcionesByValuesUseCase;
  final CreateEncuestaDetalleUseCase _createEncuestaDetalleUseCase;
  final GetAllEncuestaDetalleUseCase _getAllEncuestaDetalleUseCase;
  final UpdateEncuestaDetalleUseCase _updateEncuestaDetalleUseCase;
  final DeleteEncuestaDetalleUseCase _deleteEncuestaDetalleUseCase;
  final MigrarEncuestaDetalleUseCase _migrarEncuestaDetalleUseCase;
  final UpdateEncuestaUseCase _updateEncuestaUseCase;

  List<PersonalEmpresaEntity> personal = [];
  bool validando = false, errorNumeroDocumento=true;
  String numeroDocumento='';
  int enviados=0;

  EncuestaEntity encuestaSeleccionada;
  List<EncuestaOpcionesEntity> opciones = [];
  List<EncuestaDetalleEntity> detalles = [];

  EncuestaDetalleController(
      this._getPersonalsEmpresaUseCase,
      this._deleteEncuestaDetalleUseCase,
      this._createEncuestaDetalleUseCase,
      this._getAllEncuestaDetalleUseCase,
      this._updateEncuestaDetalleUseCase,
      this._migrarEncuestaDetalleUseCase,
      this._updateEncuestaUseCase,
      this._getAllEncuestaOpcionesByValuesUseCase);

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['encuesta'] != null) {
        encuestaSeleccionada = Get.arguments['encuesta'] as EncuestaEntity;
        update(['encuesta']);
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    validando = true;
    update(['validando']);

    detalles = await _getAllEncuestaDetalleUseCase
        .execute('${encuestaSeleccionada.id}');

    detalles.forEach((e) {
      if(e?.estado=='1') enviados=enviados+1;
    });
    personal = await _getPersonalsEmpresaUseCase.execute();
    opciones = await _getAllEncuestaOpcionesByValuesUseCase
        .execute({'idencuesta': encuestaSeleccionada.id});

    validando = false;
    update(['validando', 'encuesta']);

    super.onReady();
  }

  Future<void> goLectorCode() async {
    String barcode;

    barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    await validarCodigo(barcode);
  }

  Future<void> validarCodigo(String barcode) async{
    if (barcode != '-1') {

      

      int index = personal
          .indexWhere((e) => e.nrodocumento == barcode.toString().trim());
      if (index != -1) {

        int indexDetalle = detalles
          .indexWhere((e) => e.codigoempresa == personal[index].codigoempresa);

        if(indexDetalle!=-1){
          toastError('Error', 'Ya se encuentra registrado');
          return;
        }

        ElegirOpcionesBinding().dependencies();
        final result = await Get.to<EncuestaDetalleEntity>(
            () => ElegirOpcionesPage(),
            arguments: {
              'encuesta': encuestaSeleccionada,
              'opciones': opciones,
              'personal_seleccionado': personal[index]
            });

        if (result != null) {
          int key = await _createEncuestaDetalleUseCase.execute(
              '${encuestaSeleccionada.id}', result);
          result.key = key;
          result.estadoLocal=0;
          detalles.add(result);
          encuestaSeleccionada.cantidadTotal=detalles.length;
          await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key);
          update(['detalles']);
        }
      }
      else{
        toastError('Error', 'No se encontró el numero de documento.');
      }
    }
  }

  void goResponder() {
    ElegirOpcionesBinding().dependencies();
    Get.to(() => ElegirOpcionesPage(), arguments: {
      'encuesta': encuestaSeleccionada,
      'opciones': opciones,
    });
  }

  Future<void> goEditar(int index) async {
    ElegirOpcionesBinding().dependencies();
    final result = await Get.to<EncuestaDetalleEntity>(
        () => ElegirOpcionesPage(),
        arguments: {
          'encuesta': encuestaSeleccionada,
          'encuesta_detalle': detalles[index],
          'opciones': opciones,
          'personal_seleccionado': detalles[index].personal,
        });

    if (result != null) {
      await _updateEncuestaDetalleUseCase.execute('${encuestaSeleccionada.id}', result.key, result);
      detalles[index] = result;
      update(['detalles']);
    }
  }

  Future<void> goEliminar(int index) async{
    bool result=await basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Desea eliminar este detalle?',
      'Si',
      'No',
      () async {
        Get.back(result: true);
      },
      () => Get.back(result: false),
    );

    if(result){
      await _deleteEncuestaDetalleUseCase.execute('${encuestaSeleccionada.id}', detalles[index].key);
      if(detalles[index]?.estadoLocal==1){
        enviados=enviados-1;
      }
      detalles.removeAt(index);
      encuestaSeleccionada.cantidadTotal=detalles.length;
      encuestaSeleccionada.hayPendientes=(enviados == detalles?.length);
      await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key);
      update(['detalles']);
    }
  }

  void changeNumeroDocumento(String value){
    if(value==null){
      errorNumeroDocumento=true;
      return;
    }
    numeroDocumento=value;
    errorNumeroDocumento=false;
  }

  Future<void> searchNumeroDocumento() async{
    if(!errorNumeroDocumento){
      print('buscando');
      Get.back();
      await validarCodigo(numeroDocumento);
    }
  }

  Future<void> goSincronizar(int index) async{

    String mensaje= (detalles[index]?.estadoLocal== -1) ? 'Este detalle ha sido marcado como repetido, ¿desea sincronizar este detalle?' : '¿Desea sincronizar este detalle?';

    bool result=await basicDialog(
      Get.overlayContext,
      'Alerta',
      mensaje,
      'Si',
      'No',
      () async {
        Get.back(result: true);
      },
      () => Get.back(result: false),
    );

    if(result){
      validando=true;
      update(['validando']);
      EncuestaDetalleEntity res=await _migrarEncuestaDetalleUseCase.execute('${encuestaSeleccionada.id}', detalles[index].key);

      if(res?.estado=='A'){
        toastExito('Éxito', 'Sincronizado con éxito.');
        detalles[index].estadoLocal=1;
        await _updateEncuestaDetalleUseCase.execute('${encuestaSeleccionada.id}', detalles[index].key, detalles[index]);
        encuestaSeleccionada.cantidadTotal=detalles.length;
        enviados=enviados+1;
        encuestaSeleccionada.hayPendientes=(enviados == detalles?.length);
        await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key);
      }
      if(res?.estado=='R'){
        toastError('Error', 'Ya se encuentra en la base de datos.');
        detalles[index].estadoLocal=-1;
        await _updateEncuestaDetalleUseCase.execute('${encuestaSeleccionada.id}', detalles[index].key, detalles[index]);
      }
      validando=false;
      update(['detalles', 'validando']);
    }
  }
}
