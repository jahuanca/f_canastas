
import 'package:flutter_actividades/domain/entities/vehiculo_entity.dart';
import 'package:flutter_actividades/domain/repositories/vehiculo_repository.dart';

class GetVehiculosUseCase{
  final VehiculoRepository _vehiculoRepository;

  GetVehiculosUseCase(this._vehiculoRepository);

  Future<List<VehiculoEntity>> execute() async{
    return await _vehiculoRepository.getAll();
  }
  
}