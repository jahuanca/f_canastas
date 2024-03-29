import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/repositories/subdivision_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class SubdivisionRepositoryImplementation extends SubdivisionRepository {
  final urlModule = '/subdivision';

  @override
  Future<List<SubdivisionEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box sedesHive =
          await Hive.openBox<SubdivisionEntity>('sedes_sincronizar');
      List<SubdivisionEntity> local = [];
      sedesHive.toMap().forEach((key, value) => local.add(value));
      await sedesHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();
    final res = await http.get(
      url: urlModule,
    );

    return subdivisionEntityFromJson((res));
  }
}
