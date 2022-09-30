
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_turno_repository.dart';

class GetEncuestaTurnosUseCase{
  final EncuestaTurnoRepository _repository;

  GetEncuestaTurnosUseCase(this._repository);

  Future<List<EncuestaTurnoEntity>> execute() async{
    return await _repository.getAll();
  }
  
}