
import 'package:flutter_canastas/domain/repositories/vehiculo_temporada_repository.dart';

class DeleteVehiculoTemporadaUseCase{
  final VehiculoTemporadaRepository _vehiculoTemporadaRepository;

  DeleteVehiculoTemporadaUseCase(this._vehiculoTemporadaRepository);

  Future<void> execute(String box, int key) async{
    return await _vehiculoTemporadaRepository.delete(box, key);
  }

}