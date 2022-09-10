
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';

abstract class UsuarioRepository{

  Future<List<UsuarioEntity>> getAll();
}