
import 'package:flutter_actividades/domain/entities/personal_empresa_subdivision_entity.dart';

abstract class PersonalEmpresaSubdivisionRepository{
  Future<List<PersonalEmpresaSubdivisionEntity>> getBySubdivision();
}