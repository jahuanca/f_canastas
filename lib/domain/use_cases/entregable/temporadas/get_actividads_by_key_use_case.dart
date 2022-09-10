
import 'package:flutter_actividades/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_actividades/domain/repositories/vehiculo_temporada_repository.dart';

class GetVehiculoTemporadasByKeyUseCase{
  final VehiculoTemporadaRepository _vehiculoTemporadaRepository;

  GetVehiculoTemporadasByKeyUseCase(this._vehiculoTemporadaRepository);

  Future<List<VehiculoTemporadaEntity>> execute(String box, Map<String,dynamic> valores) async{
    return await _vehiculoTemporadaRepository.getAllByValues(box, valores);
  }
  
}