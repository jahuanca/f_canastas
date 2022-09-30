import 'package:flutter_actividades/core/encuesta/strings.dart';
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_etapa_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class EncuestaEtapaRepositoryImplementation extends EncuestaEtapaRepository {
  final urlModule = '/encuesta_etapa';

  @override
  Future<List<EncuestaEtapaEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<EncuestaEtapaEntity>(boxes['encuesta_etapa']);
      List<EncuestaEtapaEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return encuestaEtapaEntityFromJson((res));
  }

  @override
  Future<List<EncuestaEtapaEntity>> getAllByValue(Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<EncuestaEtapaEntity> dataHive =
          await Hive.openBox<EncuestaEtapaEntity>(boxes['encuesta_etapa']);
      List<EncuestaEtapaEntity> local = [];

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
