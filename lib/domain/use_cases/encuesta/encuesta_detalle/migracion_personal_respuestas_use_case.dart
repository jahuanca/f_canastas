
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/repositories/personal_respuesta_repository.dart';

class MigracionPersonalRespuestasUseCase{
  final PersonalRespuestasRepository _repository;

  MigracionPersonalRespuestasUseCase(this._repository);

  Future<List<PersonalRespuestasEntity>> execute(int idencuesta, List<PersonalRespuestasEntity> encuestaDetalle) async{
    return await _repository.migracionMasiva(idencuesta, encuestaDetalle);
  }

}