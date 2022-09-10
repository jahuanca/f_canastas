
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';
import 'package:flutter_actividades/domain/repositories/temporada_repository.dart';

class UpdateTemporadaUseCase{
  final TemporadaRepository _temporadaRepository;

  UpdateTemporadaUseCase(this._temporadaRepository);

  Future<void> execute(TemporadaEntity temporada) async{
    return await _temporadaRepository.update(temporada);
  }
  
}