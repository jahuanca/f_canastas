
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_etapa_repository.dart';

class GetEncuestaEtapasByValuesUseCase{
  final EncuestaEtapaRepository _repository;

  GetEncuestaEtapasByValuesUseCase(this._repository);

  Future<List<EncuestaEtapaEntity>> execute(Map<String, dynamic> valores) async{
    return await _repository.getAllByValue(valores);
  }
  
}