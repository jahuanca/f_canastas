import 'package:flutter_actividades/domain/entities/tipo_tarea_entity.dart';

abstract class TipoTareaRepository{

  Future<List<TipoTareaEntity>> getAll();
  Future<List<TipoTareaEntity>> getAllByValue(Map<String,dynamic> valores);
}