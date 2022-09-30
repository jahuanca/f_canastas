
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';

class UpdatePersonalRespuestasUseCase{
  final PersonalRespuestasRepository _repository;

  UpdatePersonalRespuestasUseCase(this._repository);

  Future<void> execute(String box, int key, PersonalRespuestasEntity respuesta) async{
    return await _repository.update(box, respuesta, key);
  }

}