
import 'package:flutter_canastas/domain/entities/labor_entity.dart';
import 'package:flutter_canastas/domain/repositories/labor_repository.dart';

class GetLaborsByKeyUseCase{
  final LaborRepository _laborRepository;

  GetLaborsByKeyUseCase(this._laborRepository);

  Future<List<LaborEntity>> execute(Map<String,dynamic> valores) async{
    return await _laborRepository.getAllByValue(valores);
  }
  
}