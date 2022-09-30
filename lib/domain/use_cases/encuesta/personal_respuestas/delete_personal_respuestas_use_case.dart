
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';

class DeletePersonalRespuestasUseCase{
  final PersonalRespuestasRepository _repository;

  DeletePersonalRespuestasUseCase(this._repository);

  Future<void> execute(String box, int key) async{
    return await _repository.delete(box,key);
  }

}