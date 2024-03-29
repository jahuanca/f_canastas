
import 'package:flutter_actividades/domain/entities/usuario_entity.dart';

abstract class StorageRepository {
  Future<String> getToken();
  Future<void> clearAllData();
  Future<void> saveUser(UsuarioEntity data);
  Future<void> saveToken(String token);
  Future<UsuarioEntity> getUser();
}
