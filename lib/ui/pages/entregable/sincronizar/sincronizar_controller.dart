
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/entities/centro_costo_entity.dart';
import 'package:flutter_actividades/domain/entities/cliente_entity.dart';
import 'package:flutter_actividades/domain/entities/cultivo_entity.dart';
import 'package:flutter_actividades/domain/entities/log_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_actividades/domain/entities/producto_entity.dart';
import 'package:flutter_actividades/domain/entities/punto_entrega_entity.dart';
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/entities/labor_entity.dart';
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';
import 'package:flutter_actividades/domain/entities/tipo_tarea_entity.dart';
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_entity.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_all_personal_vehiculo_by_temporada_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_clientes_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_current_time_world_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_pre_tareo_procesos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_productos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_temporadas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_tipo_tareas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_usuarios_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_vehiculos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/agregar_persona/get_personal_empresa_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_actividads_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_centro_costos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_cultivos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_punto_entregas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_labors_use_case.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter_actividades/ui/utils/string_formats.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';

class SincronizarController extends GetxController{

  List<ActividadEntity> actividades=[];
  List<LaborEntity> labores=[];
  List<SubdivisionEntity> sedes=[];
  List<UsuarioEntity> usuarios=[];
  List<PersonalEmpresaEntity> personal=[];
  List<PreTareoProcesoEntity> preTareos=[];
  List<ClienteEntity> clientes=[];
  List<PuntoEntregaEntity> puntosEntrega=[];
  int cantidadPersonalVehiculo=0;
  List<VehiculoEntity> vehiculos=[];
  List<TemporadaEntity> temporadas=[];
  List<ProductoEntity> productos=[];
  List<TipoTareaEntity> tipoTareas=[];
  List<CentroCostoEntity> centrosCosto=[];
  List<CultivoEntity> cultivos=[];

  final GetActividadsUseCase _getActividadsUseCase;
  final GetSubdivisonsUseCase _getSubdivisonsUseCase;
  final GetLaborsUseCase _getLaborsUseCase;
  final GetUsuariosUseCase _getUsuariosUseCase;
  final GetPersonalsEmpresaUseCase _getPersonalsEmpresaUseCase;
  final GetCentroCostosUseCase _getCentroCostosUseCase;
  final GetCurrentTimeWorldUseCase _getCurrentTimeWorldUseCase;
  final GetPreTareoProcesosUseCase _getPreTareoProcesosUseCase;
  final GetCultivosUseCase _getCultivosUseCase;
  final GetAllPersonalVehiculoByTemporadaUseCase _getAllPersonalVehiculoByTemporadaUseCase;
  final GetClientesUseCase _getClientesUseCase;
  final GetVehiculosUseCase _getVehiculosUseCase;
  final GetTipoTareasUseCase _getTipoTareasUseCase;
  final GetTemporadasUseCase _getTemporadasUseCase;
  final GetProductosUseCase _getProductosUseCase;
  final GetPuntoEntregasUseCase _getPuntoEntregasUseCase;

  SincronizarController(this._getActividadsUseCase, this._getSubdivisonsUseCase, this._getLaborsUseCase, this._getUsuariosUseCase, this._getPersonalsEmpresaUseCase, this._getCentroCostosUseCase, this._getCurrentTimeWorldUseCase, this._getPreTareoProcesosUseCase, this._getCultivosUseCase, this._getClientesUseCase, this._getTipoTareasUseCase, this._getVehiculosUseCase, this._getTemporadasUseCase, this._getProductosUseCase, this._getPuntoEntregasUseCase, this._getAllPersonalVehiculoByTemporadaUseCase);

  bool validando=false;

  @override
  void onInit(){
    super.onInit();
    PreferenciasUsuario().offLine=false;
    validando=true;
    update(['validando']);

  }

  @override
  void onReady()async{
    super.onReady();
    
    await getSedes();
    await getVehiculos();

    await getProductos();
    await getTemporadas();
    await getUsuarios();
    await getPersonal();
    await getPuntosEntregas();
    await getPersonalVehiculoByTemporada();

    validando=false;
    update(['validando']);
    await setLog();
    PreferenciasUsuario().offLine=true;
  }

  Future<bool> getClientes()async{
    clientes=await _getClientesUseCase.execute();
    Box<ClienteEntity> clientesSincronizados = await Hive.openBox<ClienteEntity>('clientes_sincronizar');
    
    await clientesSincronizados?.clear();
    await clientesSincronizados.addAll(clientes);
    await clientesSincronizados.close();
    update(['clientes']);
    return true;
  }

  Future<bool> getPuntosEntregas()async{
    puntosEntrega=await _getPuntoEntregasUseCase.execute();
    Box<PuntoEntregaEntity> puntosEntregaSincronizados = await Hive.openBox<PuntoEntregaEntity>('punto_entregas_sincronizar');
  
    await puntosEntregaSincronizados?.clear();
    await puntosEntregaSincronizados.addAll(puntosEntrega);
    await puntosEntregaSincronizados.close();
    update(['puntos_entrega']);
    return true;
  }

  Future<bool> getPersonalVehiculoByTemporada()async{
    cantidadPersonalVehiculo=await _getAllPersonalVehiculoByTemporadaUseCase.execute();
    /* Box<PersonalVehiculoEntity> puntosEntregaSincronizados = await Hive.openBox<PersonalVehiculoEntity>('personal_vehiculos_sincronizar');
  
    await puntosEntregaSincronizados?.clear();
    await puntosEntregaSincronizados.addAll(puntosEntrega);
    await puntosEntregaSincronizados.close(); */
    update(['personal_vehiculo']);
    return true;
  }

  Future<bool> getVehiculos()async{
    vehiculos=await _getVehiculosUseCase.execute();
    Box<VehiculoEntity> vehiculosSincronizados = await Hive.openBox<VehiculoEntity>('vehiculos_sincronizar');
    
    await vehiculosSincronizados?.clear();
    await vehiculosSincronizados.addAll(vehiculos);
    await vehiculosSincronizados.close();
    update(['vehiculos']);
    return true;
  }

  Future<bool> getTemporadas()async{
    temporadas=await _getTemporadasUseCase.execute();
    Box<TemporadaEntity> temporadasSincronizados = await Hive.openBox<TemporadaEntity>('temporadas_sincronizar');
    
    await temporadasSincronizados?.clear();
    await temporadasSincronizados.addAll(temporadas);
    await temporadasSincronizados.close();
    update(['temporadas']);
    return true;
  }

  Future<bool> getProductos()async{
    productos=await _getProductosUseCase.execute();
    Box<ProductoEntity> productosSincronizados = await Hive.openBox<ProductoEntity>('productos_sincronizar');
    
    await productosSincronizados?.clear();
    await productosSincronizados.addAll(productos);
    await productosSincronizados.close();
    update(['productos']);
    return true;
  }

  Future<bool> getTipoTareas()async{
    tipoTareas=await _getTipoTareasUseCase.execute();
    Box<TipoTareaEntity> tipoTareasSincronizados = await Hive.openBox<TipoTareaEntity>('tipo_tareas_sincronizar');
    
    await tipoTareasSincronizados?.clear();
    await tipoTareasSincronizados.addAll(tipoTareas);
    await tipoTareasSincronizados.close();
    update(['tipo_tareas']);
    return true;
  }

  Future<bool> getPreTareos()async{
    preTareos=await _getPreTareoProcesosUseCase.execute();
    Box<PreTareoProcesoEntity> preTareosSincronizados = await Hive.openBox<PreTareoProcesoEntity>('pre_tareos_sincronizar');
    
    await preTareosSincronizados?.clear();
    await preTareosSincronizados.addAll(preTareos);
    await preTareosSincronizados.close();
    update(['pre_tareos']);
    return true;
  }

  Future<bool> getActividades()async{
    actividades=await _getActividadsUseCase.execute();
    Box<ActividadEntity> actividadesSincronizadas = await Hive.openBox<ActividadEntity>('actividades_sincronizar');
    
    await actividadesSincronizadas?.clear();
    await actividadesSincronizadas.addAll(actividades);
    await actividadesSincronizadas.close();
    update(['actividades']);
    return true;
  }

  Future<void> getSedes()async{
    sedes= await _getSubdivisonsUseCase.execute();
    var sedesSincronizadas = await Hive.openBox<SubdivisionEntity>('sedes_sincronizar');
    await sedesSincronizadas.clear();
    await sedesSincronizadas.addAll(sedes);
    await sedesSincronizadas.close();
    update(['sedes']);
  }

  Future<void> getCultivos()async{
    cultivos= await _getCultivosUseCase.execute();
    var cultivosSincronizadas = await Hive.openBox<CultivoEntity>('cultivos_sincronizar');
    await cultivosSincronizadas.clear();
    await cultivosSincronizadas.addAll(cultivos);
    await cultivosSincronizadas.close();
    update(['cultivos']);
  }

  Future<void> getLabores()async{
    labores= await _getLaborsUseCase.execute();
    var laboresSincronizadas = await Hive.openBox<LaborEntity>('labores_sincronizar');
    await laboresSincronizadas.clear();
    await laboresSincronizadas.addAll(labores);
    await laboresSincronizadas.close();
    update(['labores']);
  }

  Future<void> setLog()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    var logs = await Hive.openBox<LogEntity>('log_sincronizar');
    PreferenciasUsuario().lastVersion=version;
    PreferenciasUsuario().lastVersionDate=formatoFechaHora((await _getCurrentTimeWorldUseCase.execute()).datetime);
    await logs.add(
      new LogEntity(
        id: DateTime.now().microsecond,
        fecha: DateTime.now(),
        version: version,
      )
    );
    await logs.close();
    update(['version']);
  }

  Future<void> getUsuarios()async{
    usuarios= await _getUsuariosUseCase.execute();
    var usuariosSincronizadas = await Hive.openBox<UsuarioEntity>('usuarios_sincronizar');
    await usuariosSincronizadas.clear();
    await usuariosSincronizadas.addAll(usuarios);
    await usuariosSincronizadas.close();
    update(['usuarios']);

  }

  Future<void> getPersonal()async{
    personal= await _getPersonalsEmpresaUseCase.execute();
    var personalSincronizadas = await Hive.openBox<PersonalEmpresaEntity>('personal_sincronizar');
    await personalSincronizadas.clear();
    await personalSincronizadas.addAll(personal);
    await personalSincronizadas.close();
    update(['personal_empresa']);
  }

  Future<void> getCentrosCosto()async{
    centrosCosto= await _getCentroCostosUseCase.execute();
    Box<CentroCostoEntity> centrosCostoSincronizados = await Hive.openBox<CentroCostoEntity>('centros_costo_sincronizar');
    await centrosCostoSincronizados.clear();
    await centrosCostoSincronizados.addAll(centrosCosto);
    await centrosCostoSincronizados.close();
    update(['centro_costo']);
  }


}