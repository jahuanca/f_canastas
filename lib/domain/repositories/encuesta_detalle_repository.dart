import 'dart:io';
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';

abstract class EncuestaDetalleRepository{

  Future<List<EncuestaDetalleEntity>> getAll(String box);
  Future<List<EncuestaDetalleEntity>> getAllByValues(String box, Map<String, dynamic> valores);
  Future<int> create(String box, EncuestaDetalleEntity vehiculo);
  Future<EncuestaDetalleEntity> migrar(String box, int key);
  Future<EncuestaDetalleEntity> migrarAll(String box);
  Future<List<EncuestaDetalleEntity>> migracionMasiva(int idencuesta, List<EncuestaDetalleEntity> detallesEnviar);
  Future<EncuestaDetalleEntity> uploadFile(String box, EncuestaDetalleEntity vehiculo, File fileLocal);
  Future<void> update(String box, EncuestaDetalleEntity vehiculo , int key);
  Future<void> delete(String box, int key);
}