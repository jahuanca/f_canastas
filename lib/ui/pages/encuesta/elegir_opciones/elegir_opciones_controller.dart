
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:get/get.dart';

class ElegirOpcionesController extends GetxController {
  EncuestaEntity encuestaSeleccionada;
  List<EncuestaOpcionesEntity> opciones = [];
  EncuestaOpcionesEntity opcionElegida;
  PersonalEmpresaEntity personalSeleccionado;
  String opcionManual, errorOpcionManual;
  bool editando=false;
  bool editable=true;

  ElegirOpcionesController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['encuesta'] != null) {
        encuestaSeleccionada = Get.arguments['encuesta'] as EncuestaEntity;
        update(['encuesta']);
      }
      if (Get.arguments['encuesta_detalle'] != null) {
        editando=true;
        editable=(Get.arguments['encuesta_detalle'] as EncuestaDetalleEntity)?.estadoLocal==0 ? true : false;
        opcionElegida=(Get.arguments['encuesta_detalle'] as EncuestaDetalleEntity).opcionEncuesta;
        opcionManual=(Get.arguments['encuesta_detalle'] as EncuestaDetalleEntity)?.opcionmanual;
        update(['encuesta_detalle']);
      }
      if (Get.arguments['opciones'] != null) {
        opciones = (Get.arguments['opciones'] as List<EncuestaOpcionesEntity>).toList();
        opciones.add(EncuestaOpcionesEntity(
          id: -1,
          opcion: 'OTRA',
          descripcion: 'Redacte su respuesta',
        ));
        update(['opciones']);
      }
      if (Get.arguments['personal_seleccionado'] != null) {
        personalSeleccionado =
            Get.arguments['personal_seleccionado'] as PersonalEmpresaEntity;
        update(['personal_seleccionado']);
      }
      
    }
    super.onInit();
  }

  void changeOption(int index) {
    opcionElegida = opciones[index];
    update(['opciones']);
  }

  void goGuardar(){
    EncuestaDetalleEntity detalle=EncuestaDetalleEntity(
      codigoempresa: personalSeleccionado.codigoempresa,
      idencuesta: encuestaSeleccionada.id,
      personal: personalSeleccionado,
      idopcionencuesta: opcionElegida.id == -1 ? null : opcionElegida.id,
      opcionEncuesta: opcionElegida,
      opcionmanual: opcionElegida.id==-1 ? opcionManual : null,
      fecha: DateTime.now(),
      hora: DateTime.now(),
      estadoLocal: 0,
    );

    if(!editando){
      detalle.idsubdivision=PreferenciasUsuario().idPuntoEntrega;
      detalle.idusuario=PreferenciasUsuario().idUsuario;
    }
    Get.back(result: detalle);
  }

  void changeOpcionManual(String value){
    if(value==null) errorOpcionManual='Detalle su respuesta';
    else opcionManual=value;
  }
}
