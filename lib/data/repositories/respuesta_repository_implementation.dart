
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class RespuestaRepositoryImplementation
    extends RespuestaRepository {
  final urlModule = '/respuesta';

  @override
  Future<List<RespuestaEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<RespuestaEntity>('encuesta_sincronizar');
      List<RespuestaEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      /* local.sort((a, b) => b.fechamod.compareTo(a.fechamod)); */
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return respuestaEntityFromJson(res);
  }

  @override
  Future<List<RespuestaEntity>> getAllByEncuesta(int idencuesta) async {
    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: '$urlModule/id_encuesta/$idencuesta',
    );

    return respuestaEntityFromJson(res);
  }

  
}
