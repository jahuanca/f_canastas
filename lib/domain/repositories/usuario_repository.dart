
import 'package:flutter_canastas/domain/entities/usuario_entity.dart';

abstract class UsuarioRepository{

  Future<List<UsuarioEntity>> getAll();
}