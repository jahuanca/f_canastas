
import 'package:flutter_actividades/domain/entities/tarea_proceso_entity.dart';
import 'package:flutter_actividades/domain/repositories/tarea_proceso_repository.dart';

class MigrarAllTareaUseCase{
  final TareaProcesoRepository _tareaProcesoRepository;

  MigrarAllTareaUseCase(this._tareaProcesoRepository);

  Future<TareaProcesoEntity> execute(TareaProcesoEntity tareaProcesoEntity)async{
    return await _tareaProcesoRepository.migrar(tareaProcesoEntity);
  } 
}