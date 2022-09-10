
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/update_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/get_all_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/migracion_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/update_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:get/get.dart';

class SincronizacionMasivaController extends GetxController{

  GetAllEncuestaDetalleUseCase _getAllEncuestaDetalleUseCase;
  MigracionEncuestaDetalleUseCase _migracionEncuestaDetalleUseCase;
  UpdateEncuestaDetalleUseCase _updateEncuestaDetalleUseCase;
  UpdateEncuestaUseCase _updateEncuestaUseCase;

  EncuestaEntity encuestaSeleccionada;
  List<EncuestaDetalleEntity> detalles=[];
  List<EncuestaDetalleEntity> dResultados=[];
  List<EncuestaDetalleEntity> detallesSinSincronizar=[];
  bool validando=false;
  int sincronizados=0;
  int repetidos=0;


  SincronizacionMasivaController(
    this._getAllEncuestaDetalleUseCase, 
    this._migracionEncuestaDetalleUseCase, 
    this._updateEncuestaDetalleUseCase, 
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
    detalles=await _getAllEncuestaDetalleUseCase.execute('${encuestaSeleccionada.id}');
    
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

    dResultados=await _migracionEncuestaDetalleUseCase.execute(detallesSinSincronizar);
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
      await _updateEncuestaDetalleUseCase.execute(
        '${encuestaSeleccionada.id}', 
        detallesSinSincronizar[i].key,
        detallesSinSincronizar[i]
      );
    }
    detallesSinSincronizar.clear();
    encuestaSeleccionada.hayPendientes=(sincronizados == detallesSinSincronizar?.length);
    /* encuestaSeleccionada.cantidadTotal=detalles.length+1; */
    
    await _updateEncuestaUseCase.execute(encuestaSeleccionada, encuestaSeleccionada.key);
    validando=false;
    update(['validando']);
  }

}