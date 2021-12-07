




import 'package:flutter_canastas/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_canastas/domain/repositories/personal_empresa_repository.dart';

class GetPersonalsEmpresaBySubdivisionUseCase{
  final PersonalEmpresaRepository _personalEmpresaRepository;

  GetPersonalsEmpresaBySubdivisionUseCase(this._personalEmpresaRepository);

  Future<List<PersonalEmpresaEntity>> execute(int idSubdivision) async{
    return await _personalEmpresaRepository.getAllBySubdivision(idSubdivision);
  }
}