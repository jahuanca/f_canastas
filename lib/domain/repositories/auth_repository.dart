
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';

abstract class AuthRepository{
  Future<UsuarioEntity> login(UsuarioEntity usuarioEntity);
}