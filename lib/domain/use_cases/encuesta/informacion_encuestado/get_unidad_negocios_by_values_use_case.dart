
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';
import 'package:flutter_actividades/domain/repositories/unidad_negocio_repository.dart';


class GetUnidadNegociosByValuesUseCase{
  final UnidadNegocioRepository _repository;

  GetUnidadNegociosByValuesUseCase(this._repository);

  Future<List<UnidadNegocioEntity>> execute(Map<String, dynamic> valores) async{
    return await _repository.getAllByValue(valores);
  }
  
}