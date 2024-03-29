
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_uva_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_uva_repository.dart';

class GetAllPreTareoProcesoUvaUseCase{
  final PreTareoProcesoUvaRepository _preTareoProcesoUvaRepository;

  GetAllPreTareoProcesoUvaUseCase(this._preTareoProcesoUvaRepository);

  Future<List<PreTareoProcesoUvaEntity>> execute() async{
    return await _preTareoProcesoUvaRepository.getAll();
  }

}