import 'dart:convert';

import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';
import 'package:flutter_actividades/domain/repositories/auth_repository.dart';
import 'package:flutter_actividades/ui/utils/alert_dialogs.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final urlModule = '/auth';

  @override
  Future<UsuarioEntity> login(UsuarioEntity usuarioEntity) async {
    if (PreferenciasUsuario().offLine) {
      Box<UsuarioEntity> usuariosHive =
          await Hive.openBox<UsuarioEntity>('usuarios_sincronizar');

      List<UsuarioEntity> usuarios = usuariosHive.values.toList();
      await usuariosHive.close();
      for (var i = 0; i < usuarios.length; i++) {
        var u = usuarios.elementAt(i);
        if (u.alias.trim() == usuarioEntity.alias.trim() &&
            u.password.trim() == usuarioEntity.password.trim()) {
          u.token='TOKEN_DE_PRUEBA';
          return u;
        }
      }
      toastError('Error', 'Verifique usuario o contraseña.');
      return null;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.post(
      url: '$urlModule/signIn',
      body: usuarioEntity.toJson(),
    );

    return res != null ? UsuarioEntity.fromJson(jsonDecode(res)) : null;
  }
}
