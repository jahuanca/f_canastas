
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';

abstract class EncuestaEtapaRepository{

  Future<List<EncuestaEtapaEntity>> getAll();
  Future<List<EncuestaEtapaEntity>> getAllByValue(Map<String,dynamic> valores);
}