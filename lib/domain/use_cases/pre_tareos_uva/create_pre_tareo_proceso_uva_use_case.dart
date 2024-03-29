
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_uva_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_uva_repository.dart';

class CreatePreTareoProcesoUvaUseCase{
  final PreTareoProcesoUvaRepository _preTareoProcesoUvaRepository;

  CreatePreTareoProcesoUvaUseCase(this._preTareoProcesoUvaRepository);

  Future<int> execute(PreTareoProcesoUvaEntity preTareoProcesoUvaEntity) async{
    return await _preTareoProcesoUvaRepository.create(preTareoProcesoUvaEntity);
  }

}