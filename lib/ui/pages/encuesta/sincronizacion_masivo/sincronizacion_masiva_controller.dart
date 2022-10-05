
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/migracion_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/get_all_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/personal_respuestas/update_personal_respuestas_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:get/get.dart';

class SincronizacionMasivaController extends GetxController{

  GetAllPersonalRespuestasUseCase _getAllPersonalRespuestasUseCase;
  MigracionPersonalRespuestasUseCase  _migracionPersonalRespuestasUseCase;
  UpdatePersonalRespuestasUseCase _updatePersonalRespuestasUseCase;
  UpdateEncuestaUseCase _updateEncuestaUseCase;

  EncuestaEntity encuestaSeleccionada;
  List<PersonalRespuestasEntity> detalles=[];
  List<PersonalRespuestasEntity> dResultados=[];
  List<PersonalRespuestasEntity> detallesSinSincronizar=[];
  bool validando=false;
  int sincronizados=0;
  int repetidos=0;


  SincronizacionMasivaController(
    this._getAllPersonalRespuestasUseCase, 
    this._migracionPersonalRespuestasUseCase, 
    this._updatePersonalRespuestasUseCase, 
    this._updateEncuestaUseCase
  );

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments['encuesta'] != null){
        encuestaSeleccionada=Get.arguments['encuesta'] as EncuestaEntity;
      }
    }
    super.onInit();
  }

  @override
  void onReady() async{
    validando=true;
    update(['validando']);
    detalles=await _getAllPersonalRespuestasUseCase.execute('${encuestaSeleccionada.id}');
    
    detalles.forEach((e) {
      if(e.estadoLocal!=1) detallesSinSincronizar.add(e);
    });
    validando=false;
    update(['validando', 'data']);

    super.onReady();
  }



  Future<void> goSincronizacion() async{


    final bandera=await basicDialog(
      Get.overlayContext,
      'Alerta',
      '¿Esta seguro de realizar la sincronización?',
      'Si',
      'No',
      () async {
        Get.back(result: true);
      },
      () => Get.back(result: false),
    );

    if(!bandera) return;

    validando=true;
    update(['validando']);

    sincronizados=0;
    repetidos=0;

    dResultados=await _migracionPersonalRespuestasUseCase.execute(detallesSinSincronizar);
    for (var i = 0; i < dResultados.length; i++) {
      
      switch (dResultados[i].estado) {
        case 'A':
          sincronizados=sincronizados+1;
          detallesSinSincronizar[i].estadoLocal=1;
          break;
        case 'R':
          repetidos=repetidos+1;
          detallesSinSincronizar[i].estadoLocal=-1;
          break;
        default:
          
          detallesSinSincronizar[i].estadoLocal=0;
          break;
      }
      await _updatePersonalRespuestasUseCase.execute(
        '${encuestaSeleccionada.id}', 
        detallesSinSincronizar[i].key,
        detallesSinSincronizar[i]
      );
    }
    encuestaSeleccionada.hayPendientes=((detallesSinSincronizar?.length ?? 0) > sincronizados);
    detallesSinSincronizar.clear();
    /* encuestaSeleccionada.cantidadTotal=detalles.length+1; */
    
    await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key);
    validando=false;
    update(['validando']);
  }

}