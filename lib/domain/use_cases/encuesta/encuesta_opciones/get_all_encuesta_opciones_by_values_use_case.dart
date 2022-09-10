
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_opciones_repository.dart';

class GetAllEncuestaOpcionesByValuesUseCase{
  final EncuestaOpcionesRepository _encuestaOpcionesRepository;

  GetAllEncuestaOpcionesByValuesUseCase(this._encuestaOpcionesRepository);

  Future<List<EncuestaOpcionesEntity>> execute(Map<String, dynamic> values) async{
    return await _encuestaOpcionesRepository.getAllByValue(values);
  }
}