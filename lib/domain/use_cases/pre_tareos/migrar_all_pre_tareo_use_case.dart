
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_repository.dart';

class MigrarAllPreTareoUseCase{
  final PreTareoProcesoRepository _preTareoProcesoRepository;

  MigrarAllPreTareoUseCase(this._preTareoProcesoRepository);

  Future<PreTareoProcesoEntity> execute(PreTareoProcesoEntity preTareoProcesoEntity)async{
    return await _preTareoProcesoRepository.migrar(preTareoProcesoEntity);
  } 
}