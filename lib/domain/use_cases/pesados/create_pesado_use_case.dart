
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_varios_entity.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_varios_repository.dart';

class CreatePesadoUseCase{
  final PreTareaEsparragoVariosRepository _repository;

  CreatePesadoUseCase(this._repository);

  Future<void> execute(PreTareaEsparragoVariosEntity pesado) async{
    return await _repository.create(pesado);
  }

}