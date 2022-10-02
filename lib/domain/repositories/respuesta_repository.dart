
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';

abstract class RespuestaRepository{

  Future<List<RespuestaEntity>> getAll();
  Future<List<RespuestaEntity>> getAllByEncuesta(int idencuesta);
}