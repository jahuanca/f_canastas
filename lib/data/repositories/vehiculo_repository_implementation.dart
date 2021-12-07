import 'package:flutter_canastas/data/http_manager/app_http_manager.dart';
import 'package:flutter_canastas/domain/entities/vehiculo_entity.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_repository.dart';
import 'package:flutter_canastas/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class VehiculoRepositoryImplementation extends VehiculoRepository {
  final urlModule = '/vehiculo';

  @override
  Future<List<VehiculoEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive =
          await Hive.openBox<VehiculoEntity>('vehiculos_sincronizar');
      List<VehiculoEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return vehiculoEntityFromJson((res));
  }

  @override
  Future<List<VehiculoEntity>> getAllByValue(
      Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<VehiculoEntity> dataHive =
          await Hive.openBox<VehiculoEntity>('vehiculos_sincronizar');
      List<VehiculoEntity> local = [];

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
}
