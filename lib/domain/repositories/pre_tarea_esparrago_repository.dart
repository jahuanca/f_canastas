
import 'dart:io';
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_entity.dart';

abstract class PreTareaEsparragoRepository{

  Future<List<PreTareaEsparragoEntity>> getAll();
  Future<List<PreTareaEsparragoEntity>> getAllByValue(Map<String,dynamic> valores);
  Future<int> create(PreTareaEsparragoEntity pesado);
  Future<PreTareaEsparragoEntity> migrar(PreTareaEsparragoEntity pesado);
  Future<PreTareaEsparragoEntity> uploadFile(PreTareaEsparragoEntity pesado, File fileLocal);
  Future<void> update(PreTareaEsparragoEntity pesado , int index);
  Future<void> delete(int index);
}