
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class MigrarAllEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  MigrarAllEncuestaDetalleUseCase(this._repository);

  Future<EncuestaDetalleEntity> execute(String box) async{
    return await _repository.migrarAll(box);
  } 
}