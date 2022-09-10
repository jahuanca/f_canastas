
import 'dart:convert';

import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_actividades/domain/repositories/personal_vehiculo_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class PersonalVehiculoRepositoryImplementation
    extends PersonalVehiculoRepository {
  
  final urlModule = '/personal_vehiculo';

  @override
  Future<List<PersonalVehiculoEntity>> getAll(String box) async {
    Box<PersonalVehiculoEntity> dataHive =
        await Hive.openBox<PersonalVehiculoEntity>(
            box);
    List<PersonalVehiculoEntity> local = [];
    dataHive.toMap().forEach((key, value) => local.add(value));
    await dataHive.close();
    return local;
  }

  @override
  Future<List<PersonalVehiculoEntity>> getAllByValues(
      String box, Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<PersonalVehiculoEntity> dataHive =
          await Hive.openBox<PersonalVehiculoEntity>(
              box);
      List<PersonalVehiculoEntity> local = [];

      dataHive.values.forEach((e) {
        bool guardar = true;
        valores.forEach((key, value) {
          if (e.toJson()[key] != value) {
            guardar = false;
          }
        });
        if (guardar) local.add(e);
      });
      await dataHive.close();
      return local;
    }

    return [];
  }

  @override
  Future<int> create(String box, PersonalVehiculoEntity vehiculo) async {
    var tareas = await Hive.openBox<PersonalVehiculoEntity>(
        box);
    int key = await tareas.add(vehiculo);
    vehiculo.key = key;
    tareas.put(key, vehiculo);
    return key;
  }

  @override
  Future<void> delete(String box, int index) async {
    var tareas = await Hive.openBox<PersonalVehiculoEntity>(
        box);
    await tareas.deleteAt(index);
    return tareas.close();
  }

  @override
  Future<void> update(
      String box, PersonalVehiculoEntity vehiculo, int index) async {
    var tareas = await Hive.openBox<PersonalVehiculoEntity>(
        box);
    return await tareas.put(index, vehiculo);
  }

  @override
  Future<List<PersonalVehiculoEntity>> getAllRegistrados(String box) async{
    Box<PersonalVehiculoEntity> dataHive =
        await Hive.openBox<PersonalVehiculoEntity>(
            box);
    List<PersonalVehiculoEntity> local = [];
    dataHive.toMap().forEach((key, value) => local.add(value));
    /* local.sort((a, b) => b.fechamod.compareTo(a.fechamod)); */
    await dataHive.close();
    return local;
  }

  @override
  Future<int> getAllByTemporada() async{

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: '$urlModule/bytemporada'
    );

    var j=jsonDecode(res);
    int cantidad=0;
    for (var entry in j.entries) {

      var d=await Hive.openBox<PersonalVehiculoEntity>('personal_vehiculo_sincronizar_${entry.key}');
      await d.deleteFromDisk();
      Box dataHive = await Hive.openBox<PersonalVehiculoEntity>('personal_vehiculo_sincronizar_${entry.key}');
      await dataHive.addAll((personalVehiculoEntityFromJson(jsonEncode(entry.value))).toList());
      cantidad=cantidad+ entry.value.length;
      await dataHive.close();
    }
    return cantidad;
  }

  @override
  Future<List<PersonalVehiculoEntity>> getByTemporada(int idtemporada) async{
    Box<PersonalVehiculoEntity> dataHive =
        await Hive.openBox<PersonalVehiculoEntity>(
            'personal_vehiculo_sincronizar_$idtemporada');
    List<PersonalVehiculoEntity> local = [];
    dataHive.toMap().forEach((key, value) => local.add(value));
    await dataHive.close();
    return local;
  }
}
