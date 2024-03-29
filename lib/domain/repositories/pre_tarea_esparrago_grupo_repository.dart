
import 'dart:io';
import 'package:flutter_actividades/domain/entities/pre_tarea_esparrago_grupo_entity.dart';

abstract class PreTareaEsparragoGrupoRepository{

  Future<List<PreTareaEsparragoGrupoEntity>> getAll();
  Future<List<PreTareaEsparragoGrupoEntity>> getAllByValue(Map<String,dynamic> valores);
  Future<void> create(PreTareaEsparragoGrupoEntity pesado);
  Future<PreTareaEsparragoGrupoEntity> migrar(PreTareaEsparragoGrupoEntity pesado);
  Future<PreTareaEsparragoGrupoEntity> uploadFile(PreTareaEsparragoGrupoEntity pesado, File fileLocal);
  Future<void> update(PreTareaEsparragoGrupoEntity pesado , int key);
  Future<void> delete(int key);
}