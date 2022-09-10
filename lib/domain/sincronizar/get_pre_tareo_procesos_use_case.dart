
import 'package:flutter_actividades/domain/entities/pre_tareo_proceso_entity.dart';
import 'package:flutter_actividades/domain/repositories/pre_tareo_proceso_repository.dart';


class GetPreTareoProcesosUseCase{
  final PreTareoProcesoRepository _preTareoProcesoRepository;

  GetPreTareoProcesosUseCase(this._preTareoProcesoRepository);

  Future<List<PreTareoProcesoEntity>> execute() async{
    return await _preTareoProcesoRepository.getAll();
  }
  
}