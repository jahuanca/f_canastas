
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';

abstract class ActividadRepository{

  Future<List<ActividadEntity>> getAll();
  Future<List<ActividadEntity>> getAllByValue(Map<String,dynamic> valores);
}