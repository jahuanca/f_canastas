import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_actividades/core/entregable/strings.dart';
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/encuesta_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EncuestaRepositoryImplementation
    extends EncuestaRepository {
  final urlModule = '/encuesta';

  @override
  Future<List<EncuestaEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive = await Hive.openBox<EncuestaEntity>('encuesta_sincronizar');
      List<EncuestaEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      /* local.sort((a, b) => b.fechamod.compareTo(a.fechamod)); */
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return encuestaEntityFromJson(res);
  }

  @override
  Future<List<EncuestaEntity>> getAllByValues(
      String box, Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<EncuestaEntity> dataHive =
          await Hive.openBox<EncuestaEntity>('encuesta_sincronizar');
      List<EncuestaEntity> local = [];

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
  Future<int> create(String box, EncuestaEntity encuesta) async {
    var tareas = await Hive.openBox<EncuestaEntity>(box);
    int key = await tareas.add(encuesta);
    encuesta.key = key;
    await tareas.put(key, encuesta);
    return key;
  }

  @override
  Future<void> delete(String box, int key) async {
    var tareas = await Hive.openBox<EncuestaEntity>(box);
    var t=tareas.get(key);
    await tareas.delete(key);

    await Hive.openBox('${t.key}-encuesta_detalle_$key')..deleteFromDisk();
    await tareas.close();
    return;
  }

  @override
  Future<void> update(EncuestaEntity encuesta, int key) async {
    var tareas = await Hive.openBox<EncuestaEntity>('encuesta_sincronizar');
    await tareas.put(key, encuesta);
    await tareas.close();
    return;
  }

  @override
  Future<EncuestaEntity> migrar(String box, int key) async {
    Box<EncuestaEntity> tareas =
        await Hive.openBox<EncuestaEntity>(box);

    EncuestaEntity v = tareas.get(key);

    await tareas.close();

    /* if (v.personal == null) v.personal = [];

    Box<PersonalVehiculoEntity> p = await Hive.openBox<PersonalVehiculoEntity>(
        '${v.idtemporada}-encuesta_detalle_${v.key}');
    v.personal = p.values.toList();
    await p.close(); */

    final AppHttpManager http = AppHttpManager();
    final res = await http.post(
      url: '$urlModule/createAll',
      body: v.toJson(),
    );

    return res == null ? null : v;
  }

  @override
  Future<EncuestaEntity> uploadFile(
      String box, EncuestaEntity encuesta, File fileLocal) async {
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

      for (var i = 0; i < encuesta.toJson().entries.length; i++) {
        MapEntry map = encuesta.toJson().entries.elementAt(i);
        request.fields.addAll({map.key: map.value.toString()});
      }

      print("Fields: ${request.fields.toString()}");

      print("Api ${request.method} request ${request.url}, with");
      log(request.toString());
      http.Response response =
          await http.Response.fromStream(await request.send());
      print("Result: ${response.statusCode}");
      log(response.body);
      EncuestaEntity respuesta =
          EncuestaEntity.fromJson(jsonDecode(response.body));
      encuesta.firmasupervisor = respuesta.firmasupervisor;
      return encuesta;
    } catch (e) {
      print('Error');
      log(e.toString());
      return null;
    }
  }
}
