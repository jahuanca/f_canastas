
import 'package:flutter_canastas/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_canastas/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_temporada_repository.dart';

class MigrarAllVehiculoTemporadaUseCase{
  final VehiculoTemporadaRepository _vehiculoTemporadaRepository;

  MigrarAllVehiculoTemporadaUseCase(this._vehiculoTemporadaRepository);

  Future<VehiculoTemporadaEntity> execute(String box, int key)async{
    return await _vehiculoTemporadaRepository.migrar(box, key);
  } 
}