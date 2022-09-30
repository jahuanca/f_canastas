
import 'package:flutter_actividades/di/informacion_encuestado_binding.dart';
import 'package:flutter_actividades/di/preguntas_binding.dart';
import 'package:flutter_actividades/domain/entities/detalle_respuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_by_values_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/create_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/delete_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/get_all_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/migrar_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/update_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/informacion_encuestado/informacion_encuestado_page.dart';
import 'package:flutter_actividades/ui/pages/encuesta/preguntas/preguntas_page.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class EncuestaDetalleController extends GetxController {
  final GetPersonalsEmpresaUseCase _getPersonalsEmpresaUseCase;
  final GetAllEncuestaOpcionesByValuesUseCase
      _getAllEncuestaOpcionesByValuesUseCase;
  final CreatePersonalRespuestasUseCase _createPersonalRespuestasUseCase;
  final GetAllPersonalRespuestasUseCase _getAllPersonalRespuestasUseCase;
  final UpdatePersonalRespuestasUseCase _updatePersonalRespuestasUseCase;
  final DeletePersonalRespuestasUseCase _deletePersonalRespuestasUseCase;
  final MigrarPersonalRespuestasUseCase _migrarPersonalRespuestasUseCase;
  final UpdateEncuestaUseCase _updateEncuestaUseCase;

  List<PersonalEmpresaEntity> personal = [];
  bool validando = false, errorNumeroDocumento=true;
  String numeroDocumento='';
  int enviados=0;

  EncuestaEntity encuestaSeleccionada;
  List<EncuestaOpcionesEntity> opciones = [];
  List<PersonalRespuestasEntity> personalRespondido = [];

  EncuestaDetalleController(
      this._getPersonalsEmpresaUseCase,
      this._deletePersonalRespuestasUseCase,
      this._createPersonalRespuestasUseCase,
      this._getAllPersonalRespuestasUseCase,
      this._updatePersonalRespuestasUseCase,
      this._migrarPersonalRespuestasUseCase,
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
    personalRespondido=[];
    personalRespondido = await _getAllPersonalRespuestasUseCase
        .execute('${encuestaSeleccionada.id}');

    personalRespondido.forEach((e) {
      if(e?.estadoLocal=='1') enviados=enviados+1;
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

        int indexDetalle = personalRespondido
          .indexWhere((e) => e.codigoempresa == personal[index].codigoempresa);

        if(indexDetalle!=-1){
          toastError('Error', 'Ya se encuentra registrado');
          return;
        }

        InformacionEncuestadoBinding().dependencies();
        final resultR= await Get.to<RespuestaEntity>(()=> InformacionEncuestadoPage());
        
        if(resultR == null){
          return;
        }

        PreguntasBinding().dependencies();
        final result= await Get.to<PersonalRespuestasEntity>(()=> PreguntasPage(),
          arguments: {
            'informacion': resultR,
            'encuesta': encuestaSeleccionada,
            'personal_seleccionado': personal[index] 
          }
        );

        if (result != null) {
          int key = await _createPersonalRespuestasUseCase.execute(
              '${encuestaSeleccionada.id}', result);
          result.key = key;
          personalRespondido.add(result);
          //agregar editar el key //ver el tema de idetapa,campo, turno
          /* resultR.detalles=result;
            resultR.personal=personal[index];
            resultR.codigoempresa=personal[index].codigoempresa;
          */
          /* detalles.add(resultR);
          encuestaSeleccionada.cantidadTotal=detalles.length;
          encuestaSeleccionada.hayPendientes=true;
          
          await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key); */
          update(['validando','detalles']);
        }
      }
      else{
        toastError('Error', 'No se encontró el numero de documento.');
      }
    }
  }

  Future<void> goEditar(int index) async {

    PreguntasBinding().dependencies();
        final result= await Get.to<PersonalRespuestasEntity>(()=> PreguntasPage(),
          arguments: {
            'encuesta': encuestaSeleccionada,
            'personal_seleccionado': personal[index],
            'detalle': personalRespondido[index],
            'informacion': RespuestaEntity(
              idunidad: personalRespondido[index].idunidad,
              idcampo: personalRespondido[index].idcampo,
              idetapa: personalRespondido[index].idetapa,
              idturno: personalRespondido[index].idturno,
            )
          }
        );
    
    if (result != null) {
      await _updatePersonalRespuestasUseCase.execute('${encuestaSeleccionada.id}', personalRespondido[index].key , result);
      personalRespondido[index] = result;
      /* result.key=personalRespondido[index].key; */
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
      await _deletePersonalRespuestasUseCase.execute('${encuestaSeleccionada.id}', personalRespondido[index].key);
      if(personalRespondido[index]?.estadoLocal==1){
        enviados=enviados-1;
      }
      personalRespondido.removeAt(index);
      encuestaSeleccionada.cantidadTotal=personalRespondido.length;
      encuestaSeleccionada.hayPendientes=((personalRespondido.length ?? 0) > enviados);
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

    String mensaje= (personalRespondido[index]?.estadoLocal== -1) ? 'Este detalle ha sido marcado como repetido, ¿desea sincronizar este detalle?' : '¿Desea sincronizar este detalle?';

    mensaje= (personalRespondido[index].respuestas.length < encuestaSeleccionada.preguntas.length ) ? 'Tiene preguntas por responder, ¿está seguro de migrar?' : mensaje;

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
      PersonalRespuestasEntity res =await _migrarPersonalRespuestasUseCase.execute('${encuestaSeleccionada.id}', personalRespondido[index].key);
      if(res != null){
        personalRespondido[index]=res;
        toastExito('Éxito', 'Sincronizado con éxito.');
        /* personalRespondido[index].estadoLocal=1;
        personalRespondido[index].respuestas= res.detalles;
        await _updatePersonalRespuestasUseCase.execute('${encuestaSeleccionada.id}', personalRespondido[index].key, personalRespondido[index]);
        encuestaSeleccionada.cantidadTotal=personalRespondido.length;
        enviados=enviados+1;
        encuestaSeleccionada.hayPendientes=((personalRespondido.length ?? 0) > enviados);
        await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key); */
      }else{
        toastError('Error', 'Ocurrio un error al migrar la información.');
      }
      validando=false;
      update(['detalles', 'validando']);
    }
  }
}
