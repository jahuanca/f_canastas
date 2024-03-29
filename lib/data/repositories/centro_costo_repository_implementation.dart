import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/centro_costo_entity.dart';
import 'package:flutter_actividades/domain/repositories/centro_costo_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class CentroCostoRepositoryImplementation extends CentroCostoRepository {
  final urlModule = '/centro_costo';

  @override
  Future<List<CentroCostoEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box sedesHive =
          await Hive.openBox<CentroCostoEntity>('centros_costo_sincronizar');
      List<CentroCostoEntity> local = [];
      sedesHive.toMap().forEach((key, value) => local.add(value));
      await sedesHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();
    final res = await http.get(
      url: urlModule,
    );

    return centroCostoEntityFromJson((res));
  }
}
