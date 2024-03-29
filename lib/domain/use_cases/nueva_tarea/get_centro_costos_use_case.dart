
import 'package:flutter_actividades/domain/entities/centro_costo_entity.dart';
import 'package:flutter_actividades/domain/repositories/centro_costo_repository.dart';

class GetCentroCostosUseCase{
  final CentroCostoRepository _centroCostoRepository;

  GetCentroCostosUseCase(this._centroCostoRepository);

  Future<List<CentroCostoEntity>> execute() async{
    return await _centroCostoRepository.getAll();
  }
  
}