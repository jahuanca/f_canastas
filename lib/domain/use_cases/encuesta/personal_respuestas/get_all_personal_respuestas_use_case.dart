
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';

class GetAllPersonalRespuestasUseCase{
  final PersonalRespuestasRepository _repository;

  GetAllPersonalRespuestasUseCase(this._repository);

  Future<List<PersonalRespuestasEntity>> execute(String box) async{
    return await _repository.getAll(box);
  }

}