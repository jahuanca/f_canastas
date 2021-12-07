
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_entity.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_repository.dart';

class CreateClasificacionUseCase{
  final PreTareaEsparragoRepository _repository;

  CreateClasificacionUseCase(this._repository);

  Future<int> execute(PreTareaEsparragoEntity pesado) async{
    return await _repository.create(pesado);
  }

}