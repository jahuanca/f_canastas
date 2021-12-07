
import 'package:flutter_canastas/domain/entities/usuario_entity.dart';

abstract class AuthRepository{
  Future<UsuarioEntity> login(UsuarioEntity usuarioEntity);
}