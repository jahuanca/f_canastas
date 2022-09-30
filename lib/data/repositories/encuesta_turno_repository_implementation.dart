import 'package:flutter_actividades/core/encuesta/strings.dart';
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_turno_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class EncuestaTurnoRepositoryImplementation extends EncuestaTurnoRepository {
  final urlModule = '/encuesta_turno';

  @override
  Future<List<EncuestaTurnoEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<EncuestaTurnoEntity>(boxes['encuesta_turno']);
      List<EncuestaTurnoEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return encuestaTurnoEntityFromJson((res));
  }

  @override
  Future<List<EncuestaTurnoEntity>> getAllByValue(Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<EncuestaTurnoEntity> dataHive =
          await Hive.openBox<EncuestaTurnoEntity>(boxes['encuesta_turno']);
      List<EncuestaTurnoEntity> local = [];

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
