
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class MigracionEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  MigracionEncuestaDetalleUseCase(this._repository);

  Future<List<EncuestaDetalleEntity>> execute(List<EncuestaDetalleEntity> encuestaDetalle) async{
    return await _repository.migracionMasiva(encuestaDetalle);
  }

}