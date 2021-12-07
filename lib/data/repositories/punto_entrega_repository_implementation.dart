import 'package:flutter_canastas/data/http_manager/app_http_manager.dart';
import 'package:flutter_canastas/domain/entities/punto_entrega_entity.dart';
import 'package:flutter_canastas/domain/repositories/punto_entrega_repository.dart';
import 'package:flutter_canastas/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class PuntoEntregaRepositoryImplementation extends PuntoEntregaRepository {
  final urlModule = '/punto_entrega';

  @override
  Future<List<PuntoEntregaEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box<PuntoEntregaEntity> dataHive =
          await Hive.openBox<PuntoEntregaEntity>('punto_entregas_sincronizar');
      List<PuntoEntregaEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return puntoEntregaEntityFromJson((res));
  }
 
}
