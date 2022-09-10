
import 'package:flutter/cupertino.dart';
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_detalle/get_all_encuesta_detalle_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_by_values_use_case.dart';
import 'package:flutter_actividades/ui/pages/encuesta/graficos_encuesta/PieData.dart';
import 'package:get/get.dart';

class GraficosEncuestaController extends GetxController{

  List<EncuestaDetalleEntity> detalles=[];
  List<EncuestaOpcionesEntity> opciones=[];
  List<PieData> dataSource=[];
  int mayorValor=0;
  int indexCurrent=0;
  PageController pageController=new PageController(keepPage: true);
  EncuestaEntity encuestaSeleccionada;

  bool validando=false;

  GetAllEncuestaDetalleUseCase _getAllEncuestaDetalleUseCase;
  GetAllEncuestaOpcionesByValuesUseCase _getAllEncuestaOpcionesByValuesUseCase;

  GraficosEncuestaController(this._getAllEncuestaDetalleUseCase, this._getAllEncuestaOpcionesByValuesUseCase);

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
    opciones=await _getAllEncuestaOpcionesByValuesUseCase.execute({
      'idencuesta': encuestaSeleccionada.id
    });
    poblarData();
    
    validando=false;
    update(['validando', 'data']);

    super.onReady();
  }

  void poblarData(){
    Map<int, int> values={};

    opciones.forEach((EncuestaOpcionesEntity e) {
      values[e.id]= 0;
    });

    values[-1]=0;

    detalles.forEach((e) {
      values[e.idopcionencuesta ?? -1]=(values[e?.idopcionencuesta ?? -1] ?? 0) +1;
      //values.update(e.idopcionencuesta, (value) => value+1);
    });

    dataSource.add(PieData('Otra', values[-1]));

    opciones.forEach((EncuestaOpcionesEntity e) {
      dataSource.add(PieData(e.opcion, values[e.id]));
      if(values[e.id] > mayorValor) mayorValor=values[e.id];
    });
  }

  void onChanged(int index){
    indexCurrent=index;
    pageController.jumpToPage(index);
    update(['index']);
  }

}