
import 'package:flutter_actividades/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';

class GetAllPersonalVehiculoUseCase{
  final PersonalVehiculoRepository _personalVehiculoRepository;

  GetAllPersonalVehiculoUseCase(this._personalVehiculoRepository);

  Future<List<PersonalVehiculoEntity>> execute(String box) async{
    return await _personalVehiculoRepository.getAll(box);
  }

}