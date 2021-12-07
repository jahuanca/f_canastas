
import 'package:flutter_canastas/domain/entities/labor_entity.dart';
import 'package:flutter_canastas/domain/repositories/labor_repository.dart';


class GetLaborsUseCase{
  final LaborRepository _laborRepository;

  GetLaborsUseCase(this._laborRepository);

  Future<List<LaborEntity>> execute() async{
    return await _laborRepository.getAll();
  }
  
}