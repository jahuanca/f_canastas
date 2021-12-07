


import 'package:flutter_canastas/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_canastas/domain/repositories/personal_vehiculo_repository.dart';

class UpdatePersonalVehiculoUseCase{
  final PersonalVehiculoRepository _preTareoProcesoRepository;

  UpdatePersonalVehiculoUseCase(this._preTareoProcesoRepository);

  Future<void> execute(String box, PersonalVehiculoEntity personal, int key) async{
    return await _preTareoProcesoRepository.update(box, personal ,key);
  }

}