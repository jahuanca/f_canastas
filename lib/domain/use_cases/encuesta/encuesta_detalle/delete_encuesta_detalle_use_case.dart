
import 'package:flutter_actividades/domain/repositories/encuesta_detalle_repository.dart';

class DeleteEncuestaDetalleUseCase{
  final EncuestaDetalleRepository _repository;

  DeleteEncuestaDetalleUseCase(this._repository);

  Future<void> execute(String box, int key) async{
    return await _repository.delete(box,key);
  }

}