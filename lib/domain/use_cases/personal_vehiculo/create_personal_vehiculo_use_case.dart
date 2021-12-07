
import 'package:flutter_canastas/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_canastas/domain/repositories/personal_vehiculo_repository.dart';

class CreatePersonalVehiculoUseCase{
  final PersonalVehiculoRepository _personalVehiculoRepository;

  CreatePersonalVehiculoUseCase(this._personalVehiculoRepository);

  Future<int> execute(String box, PersonalVehiculoEntity personal) async{
    return await _personalVehiculoRepository.create(box, personal);
  }

}