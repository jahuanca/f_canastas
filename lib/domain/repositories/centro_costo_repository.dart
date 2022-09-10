
import 'package:flutter_actividades/domain/entities/centro_costo_entity.dart';

abstract class CentroCostoRepository{

  Future<List<CentroCostoEntity>> getAll();
}