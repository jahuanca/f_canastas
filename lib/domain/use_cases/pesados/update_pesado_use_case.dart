
import 'package:flutter_canastas/domain/entities/pre_tarea_esparrago_varios_entity.dart';
import 'package:flutter_canastas/domain/repositories/pre_tarea_esparrago_varios_repository.dart';

class UpdatePesadoUseCase{
  final PreTareaEsparragoVariosRepository _repository;

  UpdatePesadoUseCase(this._repository);

  Future<void> execute(PreTareaEsparragoVariosEntity pesado, int index) async{
    return await _repository.update(pesado ,index);
  }

}