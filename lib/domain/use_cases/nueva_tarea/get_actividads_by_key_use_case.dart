
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/repositories/actividad_repository.dart';

class GetActividadsByKeyUseCase{
  final ActividadRepository _actividadRepository;

  GetActividadsByKeyUseCase(this._actividadRepository);

  Future<List<ActividadEntity>> execute(Map<String,dynamic> valores) async{
    return await _actividadRepository.getAllByValue(valores);
  }
  
}