
import 'package:flutter_canastas/domain/entities/cliente_entity.dart';

abstract class ClienteRepository{

  Future<List<ClienteEntity>> getAll();
  Future<List<ClienteEntity>> getAllByValue(Map<String,dynamic> valores);
}