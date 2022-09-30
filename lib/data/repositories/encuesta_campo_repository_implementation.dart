import 'package:flutter_actividades/core/encuesta/strings.dart';
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_campo_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class EncuestaCampoRepositoryImplementation extends EncuestaCampoRepository {
  final urlModule = '/encuesta_campo';

  @override
  Future<List<EncuestaCampoEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<EncuestaCampoEntity>(boxes['encuesta_campo']);
      List<EncuestaCampoEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return encuestaCampoEntityFromJson((res));
  }

  @override
  Future<List<EncuestaCampoEntity>> getAllByValue(Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<EncuestaCampoEntity> dataHive =
          await Hive.openBox<EncuestaCampoEntity>(boxes['encuesta_campo']);
      List<EncuestaCampoEntity> local = [];

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
