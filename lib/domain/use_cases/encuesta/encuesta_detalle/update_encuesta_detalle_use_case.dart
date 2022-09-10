
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class UpdateEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  UpdateEncuestaDetalleUseCase(this._repository);

  Future<void> execute(String box, int key, EncuestaDetalleEntity encuestaDetalle) async{
    return await _repository.update(box, encuestaDetalle, key);
  }

}