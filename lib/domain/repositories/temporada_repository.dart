
import 'package:flutter_actividades/domain/entities/temporada_entity.dart';

abstract class TemporadaRepository{

  Future<List<TemporadaEntity>> getAll();
  Future<List<TemporadaEntity>> getAllByValue(Map<String,dynamic> valores);
  Future<void> update(TemporadaEntity temporada);
}