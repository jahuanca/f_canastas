import 'package:flutter_canastas/data/http_manager/app_http_manager.dart';
import 'package:flutter_canastas/domain/entities/temporada_entity.dart';
import 'package:flutter_canastas/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_canastas/domain/repositories/temporada_repository.dart';
import 'package:flutter_canastas/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class TemporadaRepositoryImplementation extends TemporadaRepository {
  final urlModule = '/Temporada';

  @override
  Future<List<TemporadaEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box<TemporadaEntity> dataHive =
          await Hive.openBox<TemporadaEntity>('temporadas_sincronizar');
      List<TemporadaEntity> local = [];
      Box<VehiculoTemporadaEntity> vehiculosTemporadasHive =
          await Hive.openBox<VehiculoTemporadaEntity>(
              'vehiculos_temporada_sincronizar');

      dataHive.values.forEach((value) {
        vehiculosTemporadasHive.values.forEach((e) {
          if (value.id == e.idtemporada) {
            if (value.vehiculoTemporadas == null) value.vehiculoTemporadas = [];
            value.vehiculoTemporadas.add(e);
          }
        });
        local.add(value);
      });
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return temporadaEntityFromJson((res));
  }

  @override
  Future<List<TemporadaEntity>> getAllByValue(
      Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<TemporadaEntity> dataHive =
          await Hive.openBox<TemporadaEntity>('temporadas_sincronizar');
      List<TemporadaEntity> local = [];

      dataHive.values.forEach((e) {
        bool guardar = true;
        valores.forEach((key, value) {
          if (e.toJson()[key] != value) {
            guardar = false;
          }
        });
        if (guardar) local.add(e);
      });
      await dataHive.close();
      return local;
    }

    return [];
  }

  @override
  Future<void> update(TemporadaEntity temporada) async {
    Box<TemporadaEntity> dataHive =
        await Hive.openBox<TemporadaEntity>('temporadas_sincronizar');
    int keyObtenido = -1;

    for (var i = 0; i < dataHive.keys.length; i++) {
      var k=dataHive.keys.elementAt(i);
      var v=dataHive.get(k);
      if(v.id == temporada.id && (v.sizeVehiculos != temporada.sizeVehiculos || v.sizePersonalRegistrados != temporada.sizePersonalRegistrados)){
        keyObtenido=k;
        break;
      }
    }
    
    if (keyObtenido != -1) {
      await dataHive.put(keyObtenido, temporada);
    }
    await dataHive.close();
    return;
  }
}
