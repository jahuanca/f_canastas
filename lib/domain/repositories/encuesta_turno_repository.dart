

import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';

abstract class EncuestaTurnoRepository{

  Future<List<EncuestaTurnoEntity>> getAll();
  Future<List<EncuestaTurnoEntity>> getAllByValue(Map<String,dynamic> valores);
}