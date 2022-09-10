
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_opciones_repository.dart';

class GetAllEncuestaOpcionesUseCase{
  final EncuestaOpcionesRepository _encuestaOpcionesRepository;

  GetAllEncuestaOpcionesUseCase(this._encuestaOpcionesRepository);

  Future<List<EncuestaOpcionesEntity>> execute() async{
    return await _encuestaOpcionesRepository.getAll();
  }

}