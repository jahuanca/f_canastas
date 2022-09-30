
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_turno_repository.dart';

class GetEncuestaTurnosByValuesUseCase{
  final EncuestaTurnoRepository _repository;

  GetEncuestaTurnosByValuesUseCase(this._repository);

  Future<List<EncuestaTurnoEntity>> execute(Map<String, dynamic> valores) async{
    return await _repository.getAllByValue(valores);
  }
  
}