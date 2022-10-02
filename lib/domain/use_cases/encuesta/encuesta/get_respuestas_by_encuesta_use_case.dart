

import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';

class GetRespuestasByEncuesta{
  final RespuestaRepository _repository;

  GetRespuestasByEncuesta(this._repository);

  Future<List<RespuestaEntity>> execute(int id) async{
    return await _repository.getAllByEncuesta(id);
  }

}