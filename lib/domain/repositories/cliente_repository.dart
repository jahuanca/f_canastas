
import 'package:flutter_actividades/domain/entities/cliente_entity.dart';

abstract class ClienteRepository{

  Future<List<ClienteEntity>> getAll();
  Future<List<ClienteEntity>> getAllByValue(Map<String,dynamic> valores);
}