
import 'package:flutter_actividades/domain/entities/punto_entrega_entity.dart';
import 'package:flutter_actividades/domain/repositories/punto_entrega_repository.dart';

class GetPuntoEntregasUseCase{
  final PuntoEntregaRepository _puntoEntregaRepository;

  GetPuntoEntregasUseCase(this._puntoEntregaRepository);

  Future<List<PuntoEntregaEntity>> execute() async{
    return await _puntoEntregaRepository.getAll();
  }
  
}