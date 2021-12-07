
import 'package:flutter_canastas/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_canastas/domain/repositories/personal_empresa_repository.dart';

class GetPersonalsEmpresaUseCase{
  final PersonalEmpresaRepository _personalEmpresaRepository;

  GetPersonalsEmpresaUseCase(this._personalEmpresaRepository);

  Future<List<PersonalEmpresaEntity>> execute() async{
    return await _personalEmpresaRepository.getAll();
  }
}