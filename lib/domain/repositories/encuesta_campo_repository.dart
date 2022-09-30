
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';

abstract class EncuestaCampoRepository{

  Future<List<EncuestaCampoEntity>> getAll();
  Future<List<EncuestaCampoEntity>> getAllByValue(Map<String,dynamic> valores);
}