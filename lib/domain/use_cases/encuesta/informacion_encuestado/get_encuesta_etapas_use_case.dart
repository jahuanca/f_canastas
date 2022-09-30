
import 'package:flutter_actividades/domain/entities/encuesta_etapa_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_etapa_repository.dart';


class GetEncuestaEtapasUseCase{
  final EncuestaEtapaRepository _repository;

  GetEncuestaEtapasUseCase(this._repository);

  Future<List<EncuestaEtapaEntity>> execute() async{
    return await _repository.getAll();
  }
  
}