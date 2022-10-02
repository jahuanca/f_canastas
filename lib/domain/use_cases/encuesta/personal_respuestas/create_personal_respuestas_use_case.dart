
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/repositories/personal_respuesta_repository.dart';

class CreatePersonalRespuestasUseCase{
  final PersonalRespuestasRepository _repository;

  CreatePersonalRespuestasUseCase(this._repository);

  Future<int> execute(String box, PersonalRespuestasEntity respuesta) async{
    return await _repository.create(box, respuesta);
  }

}