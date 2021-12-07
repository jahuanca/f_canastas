
import 'package:flutter_canastas/domain/entities/subdivision_entity.dart';
import 'package:flutter_canastas/domain/repositories/subdivision_repository.dart';

class GetSubdivisonsUseCase{
  final SubdivisionRepository _subdivisionRepository;

  GetSubdivisonsUseCase(this._subdivisionRepository);

  Future<List<SubdivisionEntity>> execute() async{
    return await _subdivisionRepository.getAll();
  }
  
}