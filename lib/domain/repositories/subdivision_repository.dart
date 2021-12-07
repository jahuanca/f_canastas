
import 'package:flutter_canastas/domain/entities/subdivision_entity.dart';

abstract class SubdivisionRepository{

  Future<List<SubdivisionEntity>> getAll();
}