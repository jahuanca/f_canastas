import 'package:flutter_actividades/core/encuesta/strings.dart';
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';
import 'package:flutter_actividades/domain/repositories/unidad_negocio_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class UnidadNegocioRepositoryImplementation extends UnidadNegocioRepository {
  final urlModule = '/UnidadNegocio';

  @override
  Future<List<UnidadNegocioEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<UnidadNegocioEntity>(boxes['unidad_negocio']);
      List<UnidadNegocioEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return unidadNegocioEntityFromJson((res));
  }

  @override
  Future<List<UnidadNegocioEntity>> getAllByValue(Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<UnidadNegocioEntity> dataHive =
          await Hive.openBox<UnidadNegocioEntity>(boxes['unidad_negocio']);
      List<UnidadNegocioEntity> local = [];

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
