
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_repository.dart';

class CreatePreTareoProcesoUseCase{
  final PreTareoProcesoRepository _preTareoProcesoRepository;

  CreatePreTareoProcesoUseCase(this._preTareoProcesoRepository);

  Future<void> execute(PreTareoProcesoEntity preTareoProcesoEntity) async{
    return await _preTareoProcesoRepository.create(preTareoProcesoEntity);
  }

}