
import 'package:flutter_actividades/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';

class CreatePersonalVehiculoUseCase{
  final PersonalVehiculoRepository _personalVehiculoRepository;

  CreatePersonalVehiculoUseCase(this._personalVehiculoRepository);

  Future<int> execute(String box, PersonalVehiculoEntity personal) async{
    return await _personalVehiculoRepository.create(box, personal);
  }

}