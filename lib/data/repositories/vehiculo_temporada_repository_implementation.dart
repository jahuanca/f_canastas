import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_canastas/core/strings.dart';
import 'package:flutter_canastas/data/http_manager/app_http_manager.dart';
import 'package:flutter_canastas/domain/entities/personal_vehiculo_entity.dart';
import 'package:flutter_canastas/domain/entities/vehiculo_temporada_entity.dart';
import 'package:flutter_canastas/domain/repositories/vehiculo_temporada_repository.dart';
import 'package:flutter_canastas/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class VehiculoTemporadaRepositoryImplementation
    extends VehiculoTemporadaRepository {
  final urlModule = '/vehiculo_temporada';

  @override
  Future<List<VehiculoTemporadaEntity>> getAll(String box) async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<VehiculoTemporadaEntity>(box);
      List<VehiculoTemporadaEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      /* local.sort((a, b) => b.fechamod.compareTo(a.fechamod)); */
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return vehiculoTemporadaEntityFromJson((res));
  }

  @override
  Future<List<VehiculoTemporadaEntity>> getAllByValues(
      String box, Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<VehiculoTemporadaEntity> dataHive =
          await Hive.openBox<VehiculoTemporadaEntity>(box);
      List<VehiculoTemporadaEntity> local = [];

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
  Future<int> create(String box, VehiculoTemporadaEntity vehiculo) async {
    var tareas = await Hive.openBox<VehiculoTemporadaEntity>(box);
    int key = await tareas.add(vehiculo);
    vehiculo.key = key;
    tareas.put(key, vehiculo);
    return key;
  }

  @override
  Future<void> delete(String box, int key) async {
    var tareas = await Hive.openBox<VehiculoTemporadaEntity>(box);
    await tareas.delete(key);

    await Hive.openBox('personal_vehiculo_$key')..deleteFromDisk();
    await tareas.close();
    return;
  }

  @override
  Future<void> update(
      String box, VehiculoTemporadaEntity vehiculo, int index) async {
    var tareas = await Hive.openBox<VehiculoTemporadaEntity>(box);
    await tareas.put(index, vehiculo);
    await tareas.close();
    return;
  }

  @override
  Future<VehiculoTemporadaEntity> migrar(String box, int key) async {
    Box<VehiculoTemporadaEntity> tareas =
        await Hive.openBox<VehiculoTemporadaEntity>(box);

    VehiculoTemporadaEntity v = tareas.get(key);

    await tareas.close();

    if (v.personal == null) v.personal = [];

    Box<PersonalVehiculoEntity> p = await Hive.openBox<PersonalVehiculoEntity>(
        'personal_vehiculo_${v.key}');
    v.personal = p.values.toList();
    await p.close();

    final AppHttpManager http = AppHttpManager();
    final res = await http.post(
      url: '$urlModule/createAll',
      body: v.toJson(),
    );

    return res == null ? null : v;
  }

  @override
  Future<VehiculoTemporadaEntity> uploadFile(
      String box, VehiculoTemporadaEntity vehiculo, File fileLocal) async {
    http.MultipartFile file;
    final mimeType = mime(fileLocal.path).split('/');
    file = await http.MultipartFile.fromPath('file', fileLocal.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    print(file.contentType.toString());
    try {
      var request = http.MultipartRequest(
          'PUT', Uri.http(serverUrlCorta, '$urlModule/updateFile'));
      request.files.add(file);
      request.headers[HttpHeaders.acceptHeader] = 'application/json';
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      //request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';

      for (var i = 0; i < vehiculo.toJson().entries.length; i++) {
        MapEntry map = vehiculo.toJson().entries.elementAt(i);
        request.fields.addAll({map.key: map.value.toString()});
      }

      print("Fields: ${request.fields.toString()}");

      print("Api ${request.method} request ${request.url}, with");
      log(request.toString());
      http.Response response =
          await http.Response.fromStream(await request.send());
      print("Result: ${response.statusCode}");
      log(response.body);
      VehiculoTemporadaEntity respuesta =
          VehiculoTemporadaEntity.fromJson(jsonDecode(response.body));
      vehiculo.firmasupervisor = respuesta.firmasupervisor;
      return vehiculo;
    } catch (e) {
      print('Error');
      log(e.toString());
      return null;
    }
  }
}
