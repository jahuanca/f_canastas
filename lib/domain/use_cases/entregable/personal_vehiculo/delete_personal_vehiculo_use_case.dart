
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';

class DeletePersonalVehiculoUseCase{
  final PersonalVehiculoRepository _personalVehiculoRepository;

  DeletePersonalVehiculoUseCase(this._personalVehiculoRepository);

  Future<void> execute(String box, int key) async{
    return await _personalVehiculoRepository.delete(box, key);
  }

}