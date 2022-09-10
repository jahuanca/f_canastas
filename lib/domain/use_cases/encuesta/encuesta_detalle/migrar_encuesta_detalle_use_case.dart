
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class MigrarEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  MigrarEncuestaDetalleUseCase(this._repository);

  Future<EncuestaDetalleEntity> execute(String box, int key)async{
    return await _repository.migrar(box, key);
  } 
}