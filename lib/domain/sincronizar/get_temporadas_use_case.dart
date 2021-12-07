
import 'package:flutter_canastas/domain/entities/temporada_entity.dart';
import 'package:flutter_canastas/domain/repositories/temporada_repository.dart';

class GetTemporadasUseCase{
  final TemporadaRepository _temporadaRepository;

  GetTemporadasUseCase(this._temporadaRepository);

  Future<List<TemporadaEntity>> execute() async{
    return await _temporadaRepository.getAll();
  }
  
}