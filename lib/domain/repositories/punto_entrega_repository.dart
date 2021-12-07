
import 'package:flutter_canastas/domain/entities/punto_entrega_entity.dart';

abstract class PuntoEntregaRepository{

  Future<List<PuntoEntregaEntity>> getAll();
}