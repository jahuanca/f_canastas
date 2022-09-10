import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class GetAllEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  GetAllEncuestaDetalleUseCase(this._repository);

  Future<List<EncuestaDetalleEntity>> execute(String box) async{
    return await _repository.getAll(box);
  }

}