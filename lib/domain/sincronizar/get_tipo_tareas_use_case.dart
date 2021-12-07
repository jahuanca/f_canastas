

import 'package:flutter_canastas/domain/entities/tipo_tarea_entity.dart';
import 'package:flutter_canastas/domain/repositories/tipo_tarea_repository.dart';

class GetTipoTareasUseCase{
  final TipoTareaRepository _TipoTareaRepository;

  GetTipoTareasUseCase(this._TipoTareaRepository);

  Future<List<TipoTareaEntity>> execute() async{
    return await _TipoTareaRepository.getAll();
  }
  
}