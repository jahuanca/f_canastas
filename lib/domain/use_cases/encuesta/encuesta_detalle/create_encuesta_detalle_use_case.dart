
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class CreateEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  CreateEncuestaDetalleUseCase(this._repository);

  Future<int> execute(String box, EncuestaDetalleEntity encuestaDetalle) async{
    return await _repository.create(box, encuestaDetalle);
  }

}