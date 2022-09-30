
import 'package:flutter_actividades/data/repositories/actividad_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/centro_costo_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/cliente_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/cultivo_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/current_time_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_campo_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_etapa_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_opciones_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/encuesta_turno_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/labor_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_empresa_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/personal_vehiculo_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/pre_tareo_proceso_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/producto_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/punto_entrega_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/subdivision_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/temporada_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/tipo_tarea_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/unidad_negocio_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/usuario_repository_implementation.dart';
import 'package:flutter_actividades/data/repositories/vehiculo_repository_implementation.dart';
import 'package:flutter_actividades/domain/repositories/actividad_repository.dart';
import 'package:flutter_actividades/domain/repositories/centro_costo_repository.dart';
import 'package:flutter_actividades/domain/repositories/cliente_repository.dart';
import 'package:flutter_actividades/domain/repositories/cultivo_repository.dart';
import 'package:flutter_actividades/domain/repositories/current_time_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_campo_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_etapa_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_opciones_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_turno_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_repository.dart';
import 'package:flutter_actividades/domain/repositories/producto_repository.dart';
import 'package:flutter_actividades/domain/repositories/punto_entrega_repository.dart';
import 'package:flutter_actividades/domain/repositories/subdivision_repository.dart';
import 'package:flutter_actividades/domain/repositories/labor_repository.dart';
import 'package:flutter_actividades/domain/repositories/temporada_repository.dart';
import 'package:flutter_actividades/domain/repositories/tipo_tarea_repository.dart';
import 'package:flutter_actividades/domain/repositories/unidad_negocio_repository.dart';
import 'package:flutter_actividades/domain/repositories/usuario_repository.dart';
import 'package:flutter_actividades/domain/repositories/vehiculo_repository.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_campos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_etapas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_turnos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_unidad_negocios_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_all_personal_vehiculo_by_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_clientes_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_current_time_world_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_labors_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_pre_tareo_procesos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_productos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_temporadas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_tipo_tareas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_usuarios_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_vehiculos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/get_all_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_centro_costos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_cultivos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_punto_entregas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_actividades/ui/pages/entregable/sincronizar/sincronizar_controller.dart' as entregableSC;
import 'package:flutter_actividades/ui/pages/encuesta/sincronizar/sincronizar_controller.dart' as encuestaSC;
import 'package:get/get.dart';

class SincronizarBinding extends Bindings{

  int type;

  SincronizarBinding({this.type=0});


  @override
  void dependencies() {

    Get.lazyPut<ActividadRepository>(() => ActividadRepositoryImplementation());
    Get.lazyPut<SubdivisionRepository>(() => SubdivisionRepositoryImplementation());
    Get.lazyPut<LaborRepository>(() => LaborRepositoryImplementation());
    Get.lazyPut<UsuarioRepository>(() => UsuarioRepositoryImplementation());
    Get.lazyPut<PersonalEmpresaRepository>(() => PersonalEmpresaRepositoryImplementation());
    Get.lazyPut<CentroCostoRepository>(() => CentroCostoRepositoryImplementation());
    Get.lazyPut<CurrentTimeRepository>(() => CurrentTimeRepositoryImplementation());
    Get.lazyPut<PreTareoProcesoRepository>(() => PreTareoProcesoRepositoryImplementation());
    Get.lazyPut<CultivoRepository>(() => CultivoRepositoryImplementation());
    Get.lazyPut<ClienteRepository>(() => ClienteRepositoryImplementation());
    Get.lazyPut<TipoTareaRepository>(() => TipoTareaRepositoryImplementation());
    Get.lazyPut<VehiculoRepository>(() => VehiculoRepositoryImplementation());
    Get.lazyPut<TemporadaRepository>(() => TemporadaRepositoryImplementation());
    Get.lazyPut<ProductoRepository>(() => ProductoRepositoryImplementation());
    Get.lazyPut<PuntoEntregaRepository>(() => PuntoEntregaRepositoryImplementation());
    Get.lazyPut<PersonalVehiculoRepository>(() => PersonalVehiculoRepositoryImplementation());

    Get.lazyPut<GetActividadsUseCase>(() => GetActividadsUseCase(Get.find()));
    Get.lazyPut<GetSubdivisonsUseCase>(() => GetSubdivisonsUseCase(Get.find()));
    Get.lazyPut<GetLaborsUseCase>(() => GetLaborsUseCase(Get.find()));
    Get.lazyPut<GetUsuariosUseCase>(() => GetUsuariosUseCase(Get.find()));
    Get.lazyPut<GetCentroCostosUseCase>(() => GetCentroCostosUseCase(Get.find()));
    Get.lazyPut<GetPersonalsEmpresaUseCase>(() => GetPersonalsEmpresaUseCase(Get.find()));
    Get.lazyReplace<GetCurrentTimeWorldUseCase>(() => GetCurrentTimeWorldUseCase(Get.find()));
    Get.lazyReplace<GetPreTareoProcesosUseCase>(() => GetPreTareoProcesosUseCase(Get.find()));
    Get.lazyReplace<GetCultivosUseCase>(() => GetCultivosUseCase(Get.find()));
    Get.lazyReplace<GetClientesUseCase>(() => GetClientesUseCase(Get.find()));
    Get.lazyReplace<GetTipoTareasUseCase>(() => GetTipoTareasUseCase(Get.find()));
    Get.lazyReplace<GetVehiculosUseCase>(() => GetVehiculosUseCase(Get.find()));
    Get.lazyReplace<GetTemporadasUseCase>(() => GetTemporadasUseCase(Get.find()));
    Get.lazyReplace<GetProductosUseCase>(() => GetProductosUseCase(Get.find()));
    Get.lazyReplace<GetPuntoEntregasUseCase>(() => GetPuntoEntregasUseCase(Get.find()));
    Get.lazyReplace<GetAllPersonalVehiculoByTemporadaUseCase>(() => GetAllPersonalVehiculoByTemporadaUseCase(Get.find()));

    switch (type) {
      case 0:
        Get.lazyReplace<entregableSC.SincronizarController>(() => entregableSC.SincronizarController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));  
        break;
      case 1:
        Get.lazyPut<EncuestaRepository>(() => EncuestaRepositoryImplementation());
        Get.lazyPut<EncuestaOpcionesRepository>(() => EncuestaOpcionesRepositoryImplementation());
        Get.lazyPut<UnidadNegocioRepository>(() => UnidadNegocioRepositoryImplementation());
        Get.lazyPut<EncuestaEtapaRepository>(() => EncuestaEtapaRepositoryImplementation());
        Get.lazyPut<EncuestaCampoRepository>(() => EncuestaCampoRepositoryImplementation());
        Get.lazyPut<EncuestaTurnoRepository>(() => EncuestaTurnoRepositoryImplementation());

        Get.lazyReplace<GetAllEncuestaUseCase>(() => GetAllEncuestaUseCase(Get.find()));
        Get.lazyReplace<GetAllEncuestaOpcionesUseCase>(() => GetAllEncuestaOpcionesUseCase(Get.find()));
        Get.lazyReplace<GetUnidadNegociosUseCase>(() => GetUnidadNegociosUseCase(Get.find()));
        Get.lazyReplace<GetEncuestaEtapasUseCase>(() => GetEncuestaEtapasUseCase(Get.find()));
        Get.lazyReplace<GetEncuestaCamposUseCase>(() => GetEncuestaCamposUseCase(Get.find()));
        Get.lazyReplace<GetEncuestaTurnosUseCase>(() => GetEncuestaTurnosUseCase(Get.find()));

        Get.lazyReplace<encuestaSC.SincronizarController>(
          () => encuestaSC.SincronizarController(
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(), 
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
          ));
        break;
      default:
        break;
    }

    
  }

}