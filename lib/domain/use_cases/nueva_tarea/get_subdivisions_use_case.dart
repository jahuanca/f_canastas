
import 'package:flutter_actividades/domain/entities/subdivision_entity.dart';
import 'package:flutter_actividades/domain/repositories/subdivision_repository.dart';

class GetSubdivisonsUseCase{
  final SubdivisionRepository _subdivisionRepository;

  GetSubdivisonsUseCase(this._subdivisionRepository);

  Future<List<SubdivisionEntity>> execute() async{
    return await _subdivisionRepository.getAll();
  }
  
}