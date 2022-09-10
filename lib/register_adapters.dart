
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/log_entity.dart';
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';
import 'package:flutter_actividades/domain/entities/usuario_perfil_entity.dart';
import 'package:hive/hive.dart';

import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/entities/centro_costo_entity.dart';
import 'package:flutter_actividades/domain/entities/cliente_entity.dart';
import 'package:flutter_actividades/domain/entities/cultivo_entity.dart';
import 'package:flutter_actividades/domain/entities/division_entity.dart';
import 'package:flutter_actividades/domain/entities/labor_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_apto_temporada_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_subdivision_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_tarea_proceso_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_detalle_grupo_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_detalle_varios_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_formato_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_grupo_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_varios_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_uva_detalle_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_uva_entity.dart';
import 'package:flutter_actividades/domain/entities/presentacion_linea_entity.dart';
import 'package:flutter_actividades/domain/entities/producto_entity.dart';
import 'package:flutter_actividades/domain/entities/punto_entrega_entity.dart';
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/entities/tarea_proceso_entity.dart';
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';
import 'package:flutter_actividades/domain/entities/tipo_tarea_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_temporada_entity.dart';

  
registerAdapter(){
  
  Hive.registerAdapter(UsuarioEntityAdapter());
  Hive.registerAdapter(LogEntityAdapter());
  Hive.registerAdapter(UsuarioPerfilEntityAdapter());

  Hive.registerAdapter(TareaProcesoEntityAdapter());
  Hive.registerAdapter(ActividadEntityAdapter());
  Hive.registerAdapter(PersonalEmpresaEntityAdapter());
  Hive.registerAdapter(SubdivisionEntityAdapter());
  Hive.registerAdapter(PersonalTareaProcesoEntityAdapter());
  Hive.registerAdapter(PersonalEmpresaSubdivisionEntityAdapter());
  
  Hive.registerAdapter(CentroCostoEntityAdapter());
  Hive.registerAdapter(DivisionEntityAdapter());
  Hive.registerAdapter(LaborEntityAdapter());
  Hive.registerAdapter(PreTareoProcesoEntityAdapter());
  Hive.registerAdapter(CultivoEntityAdapter());
  Hive.registerAdapter(PresentacionLineaEntityAdapter());
  Hive.registerAdapter(PreTareoProcesoDetalleEntityAdapter());
  Hive.registerAdapter(PreTareoProcesoUvaEntityAdapter());
  Hive.registerAdapter(PreTareoProcesoUvaDetalleEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoVariosEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoDetalleVariosEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoGrupoEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoDetalleGrupoEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoFormatoEntityAdapter());
  Hive.registerAdapter(PreTareaEsparragoDetalleEntityAdapter());
  Hive.registerAdapter(ClienteEntityAdapter());
  Hive.registerAdapter(TipoTareaEntityAdapter());
  Hive.registerAdapter(VehiculoEntityAdapter());
  Hive.registerAdapter(TemporadaEntityAdapter());
  Hive.registerAdapter(ProductoEntityAdapter());
  Hive.registerAdapter(PersonalAptoTemporadaEntityAdapter());
  Hive.registerAdapter(PersonalVehiculoEntityAdapter());
  Hive.registerAdapter(VehiculoTemporadaEntityAdapter());
  Hive.registerAdapter(PuntoEntregaEntityAdapter());
  Hive.registerAdapter(EncuestaEntityAdapter());
  Hive.registerAdapter(EncuestaOpcionesEntityAdapter());
  Hive.registerAdapter(EncuestaDetalleEntityAdapter());

}


