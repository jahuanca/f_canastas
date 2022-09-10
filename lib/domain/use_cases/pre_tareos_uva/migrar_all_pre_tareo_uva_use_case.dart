
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_uva_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_uva_repository.dart';

class MigrarAllPreTareoUvaUseCase{
  final PreTareoProcesoUvaRepository _preTareoProcesoUvaRepository;

  MigrarAllPreTareoUvaUseCase(this._preTareoProcesoUvaRepository);

  Future<PreTareoProcesoUvaEntity> execute(PreTareoProcesoUvaEntity preTareoProcesoUvaEntity)async{
    return await _preTareoProcesoUvaRepository.migrar(preTareoProcesoUvaEntity);
  } 
}