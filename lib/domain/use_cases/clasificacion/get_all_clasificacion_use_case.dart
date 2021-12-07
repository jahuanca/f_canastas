
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_entity.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_repository.dart';

class GetAllClasificacionUseCase{
  final PreTareaEsparragoRepository _repository;

  GetAllClasificacionUseCase(this._repository);

  Future<List<PreTareaEsparragoEntity>> execute() async{
    return await _repository.getAll();
  }

}