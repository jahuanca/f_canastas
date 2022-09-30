
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';

class MigrarPersonalRespuestasUseCase{
  final PersonalRespuestasRepository _repository;

  MigrarPersonalRespuestasUseCase(this._repository);

  Future<PersonalRespuestasEntity> execute(String box, int key)async{
    return await _repository.migrar(box, key);
  } 
}