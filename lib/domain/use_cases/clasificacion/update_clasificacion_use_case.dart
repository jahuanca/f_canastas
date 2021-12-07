
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_entity.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_repository.dart';

class UpdateClasificacionUseCase{
  final PreTareaEsparragoRepository _repository;

  UpdateClasificacionUseCase(this._repository);

  Future<void> execute(PreTareaEsparragoEntity pesado, int index) async{
    return await _repository.update(pesado ,index);
  }

}