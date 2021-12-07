



import 'package:flutter_canastas/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_temporada_repository.dart';

class GetAllVehiculoTemporadaUseCase{
  final VehiculoTemporadaRepository _VehiculoTemporadaRepository;

  GetAllVehiculoTemporadaUseCase(this._VehiculoTemporadaRepository);

  Future<List<VehiculoTemporadaEntity>> execute(String box) async{
    return await _VehiculoTemporadaRepository.getAll(box);
  }

}