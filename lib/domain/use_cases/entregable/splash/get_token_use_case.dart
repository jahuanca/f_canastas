

import 'package:flutter_actividades/domain/repositories/entregable/storage_repository.dart';

class GetTokenUseCase{
  final StorageRepository _storageRepository;

  GetTokenUseCase(this._storageRepository);

  Future<String> execute() async{
    return await _storageRepository.getToken();
  }

}