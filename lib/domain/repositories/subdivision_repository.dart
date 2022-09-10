
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';

abstract class SubdivisionRepository{

  Future<List<SubdivisionEntity>> getAll();
}