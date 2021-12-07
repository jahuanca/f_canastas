
import 'dart:io';
import 'package:flutter_canastas/domain/entities/vehiculo_temporada_entity.dart';

abstract class VehiculoTemporadaRepository{

  Future<List<VehiculoTemporadaEntity>> getAll(String box);
  Future<List<VehiculoTemporadaEntity>> getAllByValues(String box, Map<String, dynamic> valores);
  Future<int> create(String box, VehiculoTemporadaEntity vehiculo);
  Future<VehiculoTemporadaEntity> migrar(String box, int key);
  Future<VehiculoTemporadaEntity> uploadFile(String box, VehiculoTemporadaEntity vehiculo, File fileLocal);
  Future<void> update(String box, VehiculoTemporadaEntity vehiculo , int key);
  Future<void> delete(String box, int key);
}