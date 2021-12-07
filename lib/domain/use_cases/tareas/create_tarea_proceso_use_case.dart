
import 'package:flutter_canastas/domain/entities/tarea_proceso_entity.dart';
import 'package:flutter_canastas/domain/repositories/tarea_proceso_repository.dart';

class CreateTareaProcesoUseCase{
  final TareaProcesoRepository _tareaProcesoRepository;

  CreateTareaProcesoUseCase(this._tareaProcesoRepository);

  Future<int> execute(TareaProcesoEntity tareaProcesoEntity) async{
    return await _tareaProcesoRepository.create(tareaProcesoEntity);
  }

}