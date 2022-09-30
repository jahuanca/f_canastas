
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_campo_repository.dart';

class GetEncuestaCamposUseCase{
  final EncuestaCampoRepository _repository;

  GetEncuestaCamposUseCase(this._repository);

  Future<List<EncuestaCampoEntity>> execute() async{
    return await _repository.getAll();
  }
  
}