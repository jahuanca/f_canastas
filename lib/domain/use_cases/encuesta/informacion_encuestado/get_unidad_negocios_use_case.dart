
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';
import 'package:flutter_actividades/domain/repositories/unidad_negocio_repository.dart';


class GetUnidadNegociosUseCase{
  final UnidadNegocioRepository _repository;

  GetUnidadNegociosUseCase(this._repository);

  Future<List<UnidadNegocioEntity>> execute() async{
    return await _repository.getAll();
  }
  
}