
import 'package:flutter_canastas/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_canastas/domain/repositories/personal_vehiculo_repository.dart';

class GetPersonalVehiculoByTemporadaUseCase{
  final PersonalVehiculoRepository _personalVehiculoByTemporadaRepository;

  GetPersonalVehiculoByTemporadaUseCase(this._personalVehiculoByTemporadaRepository);

  Future<List<PersonalVehiculoEntity>> execute(int idtemporada) async{
    return await _personalVehiculoByTemporadaRepository.getByTemporada(idtemporada);
  }

}