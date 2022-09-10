



import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';

class GetAllEncuestaUseCase{
  final EncuestaRepository _encuestaRepository;

  GetAllEncuestaUseCase(this._encuestaRepository);

  Future<List<EncuestaEntity>> execute() async{
    return await _encuestaRepository.getAll();
  }

}