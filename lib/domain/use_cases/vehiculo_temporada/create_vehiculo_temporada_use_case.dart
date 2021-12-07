
import 'package:flutter_canastas/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_temporada_repository.dart';

class CreateVehiculoTemporadaUseCase{
  final VehiculoTemporadaRepository _vehiculoTemporadaRepository;

  CreateVehiculoTemporadaUseCase(this._vehiculoTemporadaRepository);

  Future<int> execute(String box, VehiculoTemporadaEntity vehiculo) async{
    return await _vehiculoTemporadaRepository.create(box, vehiculo);
  }

}