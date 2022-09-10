
import 'package:flutter_actividades/di/encuesta_detalle_binding.dart';
import 'package:flutter_actividades/di/graficos_encuesta_binding.dart';
import 'package:flutter_actividades/di/sincronizacion_masiva_binding.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/get_all_encuesta_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/graficos_encuesta/graficos_encuesta_page.dart';
import 'package:flutter_actividades/ui/pages/encuesta/sincronizacion_masivo/sincronizacion_masiva_page.dart';
import 'package:flutter_actividades/ui/pages/encuesta_detalle/encuesta_detalle_page.dart';
import 'package:get/get.dart';

class EncuestasController extends GetxController{

  GetAllEncuestaUseCase _getAllEncuestaUseCase;

  List<int> seleccionados=[]; 
  List<EncuestaEntity> encuestas=[];
  bool validando=false;

  EncuestasController(this._getAllEncuestaUseCase);

  @override
  void onReady() async{
    super.onReady();
    validando=true;
    update(['validando']);
    encuestas= await _getAllEncuestaUseCase.execute();
    validando=false;
    update(['validando', 'encuestas']);
  }


  void seleccionar(int index){

  }

  void changeOptions(int value, int index){
    
  }

  Future<void> goDetalleEncuesta(int index) async{
    EncuestaDetalleBinding().dependencies();
    await Get.to(()=> EncuestaDetallePage(),
      arguments: {
        'encuesta': encuestas[index],
      }
    );
    update(['encuestas']);
  }

  void goGraficos(int index){

    GraficosEncuestaBinding().dependencies();

    Get.to(()=> GraficosEncuestaPage(),
      arguments: {
        'encuesta': encuestas[index],
      }
    );
  }

  Future<void> goSincronizacionMasiva(int index) async{

    SincronizacionMasivaBinding().dependencies();

    final result=await Get.to(()=> SincronizacionMasivaPage(),
      arguments: {
        'encuesta': encuestas[index],
      }
    );

    if(result != null){
      
      update(['encuestas']);
    }
  }
  

}