import 'dart:io';
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';

abstract class PersonalRespuestasRepository{

  Future<List<PersonalRespuestasEntity>> getAll(String box);
  Future<List<PersonalRespuestasEntity>> getAllByValues(String box, Map<String, dynamic> valores);
  Future<int> create(String box, PersonalRespuestasEntity personal);
  Future<PersonalRespuestasEntity> migrar(String box, int key);
  Future<PersonalRespuestasEntity> migrarAll(String box);
  Future<List<PersonalRespuestasEntity>> migracionMasiva(List<PersonalRespuestasEntity> detallesEnviar);
  Future<PersonalRespuestasEntity> uploadFile(String box, PersonalRespuestasEntity personal, File fileLocal);
  Future<void> update(String box, PersonalRespuestasEntity personal , int key);
  Future<void> delete(String box, int key);
}