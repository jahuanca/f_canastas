
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_grupo_entity.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_grupo_repository.dart';

class UpdateSeleccionUseCase{
  final PreTareaEsparragoGrupoRepository _repository;

  UpdateSeleccionUseCase(this._repository);

  Future<void> execute(PreTareaEsparragoGrupoEntity pesado, int key) async{
    return await _repository.update(pesado ,key);
  }

}