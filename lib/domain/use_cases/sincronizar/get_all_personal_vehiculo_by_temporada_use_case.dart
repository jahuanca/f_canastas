
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';

class GetAllPersonalVehiculoByTemporadaUseCase{
  final PersonalVehiculoRepository _personalVehiculoByTemporadaRepository;

  GetAllPersonalVehiculoByTemporadaUseCase(this._personalVehiculoByTemporadaRepository);

  Future<int> execute() async{
    return await _personalVehiculoByTemporadaRepository.getAllByTemporada();
  }

}