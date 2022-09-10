


import 'package:flutter_actividades/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_actividades/domain/repositories/vehiculo_temporada_repository.dart';

class UpdateVehiculoTemporadaUseCase{
  final VehiculoTemporadaRepository _preTareoProcesoRepository;

  UpdateVehiculoTemporadaUseCase(this._preTareoProcesoRepository);

  Future<void> execute(String box, VehiculoTemporadaEntity vehiculo, int key) async{
    return await _preTareoProcesoRepository.update(box, vehiculo ,key);
  }

}