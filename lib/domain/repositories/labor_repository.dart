
import 'package:flutter_canastas/domain/entities/labor_entity.dart';

abstract class LaborRepository{

  Future<List<LaborEntity>> getAll();
  Future<List<LaborEntity>> getAllByValue(Map<String,dynamic> valores);
}