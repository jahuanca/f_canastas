
import 'package:flutter_canastas/domain/entities/cultivo_entity.dart';
import 'package:flutter_canastas/domain/repositories/cultivo_repository.dart';

class GetCultivosUseCase{
  final CultivoRepository _cultivoRepository;

  GetCultivosUseCase(this._cultivoRepository);

  Future<List<CultivoEntity>> execute() async{
    return await _cultivoRepository.getAll();
  }
  
}