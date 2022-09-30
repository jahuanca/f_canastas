
import 'package:flutter_actividades/domain/entities/unidad_negocio_entity.dart';

abstract class UnidadNegocioRepository{

  Future<List<UnidadNegocioEntity>> getAll();
  Future<List<UnidadNegocioEntity>> getAllByValue(Map<String,dynamic> valores);
}