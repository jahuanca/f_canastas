
import 'package:flutter_actividades/domain/entities/cliente_entity.dart';
import 'package:flutter_actividades/domain/repositories/cliente_repository.dart';

class GetClientesUseCase{
  final ClienteRepository _clienteRepository;

  GetClientesUseCase(this._clienteRepository);

  Future<List<ClienteEntity>> execute() async{
    return await _clienteRepository.getAll();
  }
  
}