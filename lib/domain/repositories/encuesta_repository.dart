import 'dart:io';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';

abstract class EncuestaRepository{

  Future<List<EncuestaEntity>> getAll();
  Future<List<EncuestaEntity>> getAllByValues(String box, Map<String, dynamic> valores);
  Future<int> create(String box, EncuestaEntity vehiculo);
  Future<EncuestaEntity> migrar(String box, int key);
  Future<EncuestaEntity> uploadFile(String box, EncuestaEntity vehiculo, File fileLocal);
  Future<void> update(EncuestaEntity vehiculo , int key);
  Future<void> delete(String box, int key);
}