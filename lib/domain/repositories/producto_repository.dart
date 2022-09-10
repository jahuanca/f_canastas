
import 'package:flutter_actividades/domain/entities/producto_entity.dart';

abstract class ProductoRepository{

  Future<List<ProductoEntity>> getAll();
  Future<List<ProductoEntity>> getAllByValue(Map<String,dynamic> valores);
}