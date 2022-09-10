
import 'package:flutter_actividades/domain/repositories/pre_tarea_esparrago_repository.dart';

class DeleteClasificacionUseCase{
  final PreTareaEsparragoRepository _repository;

  DeleteClasificacionUseCase(this._repository);

  Future<void> execute(int index) async{
    return await _repository.delete(index);
  }

}