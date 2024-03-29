
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tarea_esparrago_repository.dart';


class MigrarAllClasificacionUseCase{
  final PreTareaEsparragoRepository _repository;

  MigrarAllClasificacionUseCase(this._repository);

  Future<PreTareaEsparragoEntity> execute(PreTareaEsparragoEntity pesado)async{
    return await _repository.migrar(pesado);
  } 
}