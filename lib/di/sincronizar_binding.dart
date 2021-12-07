
import 'package:flutter_canastas/data/repositories/actividad_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/centro_costo_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/cliente_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/cultivo_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/current_time_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/labor_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/personal_empresa_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/personal_vehiculo_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/pre_tareo_proceso_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/producto_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/punto_entrega_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/subdivision_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/temporada_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/tipo_tarea_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/usuario_repository_implementation.dart';
import 'package:flutter_canastas/data/repositories/vehiculo_repository_implementation.dart';
import 'package:flutter_canastas/domain/repositories/actividad_repository.dart';
import 'package:flutter_canastas/domain/repositories/centro_costo_repository.dart';
import 'package:flutter_canastas/domain/repositories/cliente_repository.dart';
import 'package:flutter_canastas/domain/repositories/cultivo_repository.dart';
import 'package:flutter_canastas/domain/repositories/current_time_repository.dart';
import 'package:flutter_canastas/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_canastas/domain/repositories/personal_vehiculo_repository.dart';
import 'package:flutter_canastas/domain/repositories/pre_tareo_proceso_repository.dart';
import 'package:flutter_canastas/domain/repositories/producto_repository.dart';
import 'package:flutter_canastas/domain/repositories/punto_entrega_repository.dart';
import 'package:flutter_canastas/domain/repositories/subdivision_repository.dart';
import 'package:flutter_canastas/domain/repositories/labor_repository.dart';
import 'package:flutter_canastas/domain/repositories/temporada_repository.dart';
import 'package:flutter_canastas/domain/repositories/tipo_tarea_repository.dart';
import 'package:flutter_canastas/domain/repositories/usuario_repository.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_repository.dart';
import 'package:flutter_canastas/domain/sincronizar/get_all_personal_vehiculo_by_temporada_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_clientes_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_current_time_world_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_labors_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_pre_tareo_procesos_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_productos_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_temporadas_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_tipo_tareas_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_usuarios_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_vehiculos_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_canastas/domain/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/nueva_tarea/get_centro_costos_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/nueva_tarea/get_cultivos_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/nueva_tarea/get_punto_entregas_use_case.dart';
import 'package:flutter_canastas/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_canastas/ui/pages/sincronizar/sincronizar_controller.dart';
import 'package:get/get.dart';

class SincronizarBinding extends Bindings{


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

    Get.lazyPut<SincronizarController>(() => SincronizarController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    
  }

}