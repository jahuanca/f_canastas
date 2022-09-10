
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';

abstract class PersonalEmpresaRepository{
  Future<List<PersonalEmpresaEntity>> getAll();
  Future<List<PersonalEmpresaEntity>> getAllBySubdivision(int idSubdivision);
}