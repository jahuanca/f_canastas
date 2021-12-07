
import 'package:flutter_canastas/domain/entities/vehiculo_entity.dart';

abstract class VehiculoRepository{

  Future<List<VehiculoEntity>> getAll();
  Future<List<VehiculoEntity>> getAllByValue(Map<String,dynamic> valores);
}