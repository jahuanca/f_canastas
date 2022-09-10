
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';

class UpdateEncuestaUseCase{
  final EncuestaRepository _repository;

  UpdateEncuestaUseCase(this._repository);

  Future<void> execute(EncuestaEntity data, int key) async{
    return await _repository.update(data, key);
  }
  
}