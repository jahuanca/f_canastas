
import 'package:flutter_canastas/domain/entities/personal_vehiculo_entity.dart';

abstract class PersonalVehiculoRepository{

  Future<List<PersonalVehiculoEntity>> getAll(String box);
  Future<List<PersonalVehiculoEntity>> getByTemporada(int idtemporada);
  Future<int> getAllByTemporada();
  Future<List<PersonalVehiculoEntity>> getAllRegistrados(String box);
  Future<List<PersonalVehiculoEntity>> getAllByValues(String box,Map<String, dynamic> valores);
  Future<int> create(String box, PersonalVehiculoEntity vehiculo);
  Future<void> update(String box, PersonalVehiculoEntity vehiculo , int key);
  Future<void> delete(String box,int key);
}