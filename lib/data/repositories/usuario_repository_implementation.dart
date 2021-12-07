
import 'package:flutter_canastas/data/http_manager/app_http_manager.dart';
import 'package:flutter_canastas/domain/entities/usuario_entity.dart';
import 'package:flutter_canastas/domain/repositories/usuario_repository.dart';

class UsuarioRepositoryImplementation extends UsuarioRepository {
  final urlModule = '/usuario';

  @override
  Future<List<UsuarioEntity>> getAll() async {
    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: '$urlModule/',
    );

    return usuarioEntityFromJson(res);
  }
}
