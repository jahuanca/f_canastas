
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_campo_repository.dart';

class GetEncuestaCamposByValuesUseCase{
  final EncuestaCampoRepository _repository;

  GetEncuestaCamposByValuesUseCase(this._repository);

  Future<List<EncuestaCampoEntity>> execute(Map<String, dynamic> valores) async{
    return await _repository.getAllByValue(valores);
  }
  
}