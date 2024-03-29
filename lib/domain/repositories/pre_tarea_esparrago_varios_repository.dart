
import 'dart:io';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_varios_entity.dart';

abstract class PreTareaEsparragoVariosRepository{

  Future<List<PreTareaEsparragoVariosEntity>> getAll();
  Future<List<PreTareaEsparragoVariosEntity>> getAllByValue(Map<String,dynamic> valores);
  Future<void> create(PreTareaEsparragoVariosEntity pesado);
  Future<PreTareaEsparragoVariosEntity> migrar(PreTareaEsparragoVariosEntity pesado);
  Future<PreTareaEsparragoVariosEntity> uploadFile(PreTareaEsparragoVariosEntity pesado, File fileLocal);
  Future<void> update(PreTareaEsparragoVariosEntity pesado , int index);
  Future<void> delete(int index);
}