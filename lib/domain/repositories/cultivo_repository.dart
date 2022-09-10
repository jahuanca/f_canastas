
import 'package:flutter_actividades/domain/entities/cultivo_entity.dart';

abstract class CultivoRepository{

  Future<List<CultivoEntity>> getAll();
  Future<List<CultivoEntity>> getAllByValue(Map<String,dynamic> valores);
}