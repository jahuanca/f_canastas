
import 'package:flutter_actividades/core/encuesta/strings.dart';
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/entities/centro_costo_entity.dart';
import 'package:flutter_actividades/domain/entities/cliente_entity.dart';
import 'package:flutter_actividades/domain/entities/cultivo_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:flutter_actividades/domain/entities/log_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_actividades/domain/entities/producto_entity.dart';
import 'package:flutter_actividades/domain/entities/punto_entrega_entity.dart';
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/entities/labor_entity.dart';
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';
import 'package:flutter_actividades/domain/entities/tipo_tarea_entity.dart';
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_entity.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/get_respuestas_by_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_campos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_etapas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_encuesta_turnos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/informacion_encuestado/get_unidad_negocios_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_actividads_use_case.dart';
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
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta/get_all_encuesta_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/encuesta/encuesta_opciones/get_all_encuesta_opciones_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_centro_costos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_cultivos_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_punto_entregas_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/nueva_tarea/get_subdivisions_use_case.dart';
import 'package:flutter_actividades/domain/use_cases/sincronizar/get_labors_use_case.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
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
  List<UnidadNegocioEntity> unidadesNegocio=[];
  List<EncuestaEtapaEntity> encuestaEtapas=[];
  List<EncuestaCampoEntity> encuestaCampos=[];
  List<EncuestaTurnoEntity> encuestaTurnos=[];
  List<PuntoEntregaEntity> puntosEntrega=[];
  int cantidadPersonalVehiculo=0;
  List<VehiculoEntity> vehiculos=[];
  List<TemporadaEntity> temporadas=[];
  List<ProductoEntity> productos=[];
  List<TipoTareaEntity> tipoTareas=[];
  List<CentroCostoEntity> centrosCosto=[];
  List<CultivoEntity> cultivos=[];
  List<EncuestaEntity> encuestas=[];
  List<EncuestaOpcionesEntity> encuestaOpciones=[];

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
  final GetAllEncuestaUseCase _getAllEncuestaUseCase;
  final GetAllEncuestaOpcionesUseCase _getAllEncuestaOpcionesUseCase;
  final GetUnidadNegociosUseCase _getUnidadNegociosUseCase;
  final GetEncuestaEtapasUseCase _getEncuestaEtapasUseCase;
  final GetEncuestaCamposUseCase _getEncuestaCamposUseCase;
  final GetEncuestaTurnosUseCase _getEncuestaTurnosUseCase;
  final GetRespuestasByEncuesta _getRespuestasByEncuesta;

  SincronizarController(
      this._getActividadsUseCase,
      this._getSubdivisonsUseCase,
      this._getLaborsUseCase,
      this._getUsuariosUseCase,
      this._getPersonalsEmpresaUseCase,
      this._getCentroCostosUseCase, 
      this._getCurrentTimeWorldUseCase, 
      this._getPreTareoProcesosUseCase, 
      this._getCultivosUseCase, 
      this._getClientesUseCase, 
      this._getTipoTareasUseCase, 
      this._getVehiculosUseCase, 
      this._getTemporadasUseCase, 
      this._getProductosUseCase, 
      this._getPuntoEntregasUseCase, 
      this._getAllPersonalVehiculoByTemporadaUseCase, 
      this._getAllEncuestaUseCase, 
      this._getAllEncuestaOpcionesUseCase,
      this._getUnidadNegociosUseCase,
      this._getEncuestaEtapasUseCase,
      this._getEncuestaCamposUseCase,
      this._getEncuestaTurnosUseCase,
      this._getRespuestasByEncuesta,
    );

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

    try {
      await getSedes();
      await getUsuarios();
      await getPersonal();
      await getPuntosEntregas();
      await getEncuestas();
      await getUnidadesNegocio();
      await getEncuestaCampo();
      await getEncuestaEtapa();
      await getEncuestaTurno();
      /* await getEncuestaOpciones(); */
      await setLog();
      PreferenciasUsuario().offLine=true;
      validando=false;
      update(['validando']);

    } catch (e) {
      print(e.toString());
      PreferenciasUsuario().offLine=true;
      validando=false;
      update(['validando']);
      toastError('Error', 'No se pudo sincronizar la información. vuelva a intentarlo.');
    }
    
  }

  Future<bool> getEncuestaTurno()async{
    encuestaTurnos=await _getEncuestaTurnosUseCase.execute();
    Box<EncuestaTurnoEntity> datos = await Hive.openBox<EncuestaTurnoEntity>(boxes['encuesta_turno']);
    
    await datos?.clear();
    await datos.addAll(encuestaTurnos);
    await datos.close();
    update(['encuesta_turno']);
    return true;
  }

  Future<bool> getEncuestaCampo()async{
    encuestaCampos=await _getEncuestaCamposUseCase.execute();
    Box<EncuestaCampoEntity> datos = await Hive.openBox<EncuestaCampoEntity>(boxes['encuesta_campo']);
    
    await datos?.clear();
    await datos.addAll(encuestaCampos);
    await datos.close();
    update(['encuesta_campo']);
    return true;
  }

  Future<bool> getEncuestaEtapa()async{
    encuestaEtapas=await _getEncuestaEtapasUseCase.execute();
    Box<EncuestaEtapaEntity> datos = await Hive.openBox<EncuestaEtapaEntity>(boxes['encuesta_etapa']);
    
    await datos?.clear();
    await datos.addAll(encuestaEtapas);
    await datos.close();
    update(['encuesta_etapa']);
    return true;
  }

  Future<bool> getUnidadesNegocio()async{
    unidadesNegocio=await _getUnidadNegociosUseCase.execute();
    Box<UnidadNegocioEntity> unidadesSincronizados = await Hive.openBox<UnidadNegocioEntity>(boxes['unidad_negocio']);
    
    await unidadesSincronizados?.clear();
    await unidadesSincronizados.addAll(unidadesNegocio);
    await unidadesSincronizados.close();
    update(['unidad_negocio']);
    return true;
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

  Future<bool> getEncuestas()async{
    encuestas=await _getAllEncuestaUseCase.execute();
    Box<EncuestaEntity> encuestasSincronizados = await Hive.openBox<EncuestaEntity>('encuesta_sincronizar');
  
    await encuestasSincronizados?.clear();
    for (int i = 0; i < encuestas.length; i++) {
      print('nuevo $i');

      int key=await encuestasSincronizados.add(encuestas[i]);
      encuestas[i].key=key;
      encuestas[i].hayPendientes=false;
      encuestas[i].respuestasEncuesta=(await _getRespuestasByEncuesta.execute(encuestas[i].id)) ?? [];

      encuestasSincronizados.put(key, encuestas[i]);
    }
    //await encuestasSincronizados.addAll(encuestas);
    await encuestasSincronizados.close();
    update(['encuestas']);
    return true;
  }

  Future<bool> getEncuestaOpciones()async{
    encuestaOpciones=await _getAllEncuestaOpcionesUseCase.execute();
    Box<EncuestaOpcionesEntity> encuestaOpcionesSincronizar = await Hive.openBox<EncuestaOpcionesEntity>('encuesta_opciones_sincronizar');
  
    await encuestaOpcionesSincronizar?.clear();
    await encuestaOpcionesSincronizar.addAll(encuestaOpciones);
    await encuestaOpcionesSincronizar.close();
    update(['encuesta_opciones']);
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