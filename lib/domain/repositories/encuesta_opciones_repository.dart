
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';

abstract class EncuestaOpcionesRepository{

  Future<List<EncuestaOpcionesEntity>> getAll();
  Future<List<EncuestaOpcionesEntity>> getAllByValue(Map<String,dynamic> valores);
  Future<void> update(EncuestaOpcionesEntity temporada);
}