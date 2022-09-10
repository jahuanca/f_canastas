
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_grupo_entity.dart';

import 'package:flutter_actividades/domain/repositories/pre_tarea_esparrago_grupo_repository.dart';

class MigrarAllSeleccionUseCase{
  final PreTareaEsparragoGrupoRepository _repository;

  MigrarAllSeleccionUseCase(this._repository);

  Future<PreTareaEsparragoGrupoEntity> execute(PreTareaEsparragoGrupoEntity pesado)async{
    return await _repository.migrar(pesado);
  } 
}