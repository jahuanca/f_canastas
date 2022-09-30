import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_actividades/core/entregable/strings.dart';
import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/personal_respuestas_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:flutter_actividades/domain/repositories/respuesta_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PersonalRespuestasRepositoryImplementation
    extends PersonalRespuestasRepository {
  final urlModule = '/respuesta';

  @override
  Future<List<PersonalRespuestasEntity>> getAll(String box) async {
    if (true) {
      Box dataHive = await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');
      List<PersonalRespuestasEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      /* local.sort((a, b) => b.fechamod.compareTo(a.fechamod)); */
      await dataHive.close();
      return local;
    }

  }

  @override
  Future<List<PersonalRespuestasEntity>> getAllByValues(
      String box, Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<PersonalRespuestasEntity> dataHive =
          await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');
      List<PersonalRespuestasEntity> local = [];

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
  Future<int> create(String box, PersonalRespuestasEntity encuesta) async {
    var tareas = await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');
    int key = await tareas.add(encuesta);
    encuesta.key = key;
    await tareas.put(key, encuesta);
    await tareas.close();
    return key;
  }

  @override
  Future<void> delete(String box, int key) async {
    var tareas = await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');
    /* var t=tareas.get(key); */
    await tareas.delete(key);
    /* await Hive.openBox('${t.key}-encuesta_detalle_$key')..deleteFromDisk(); */
    await tareas.close();
    return;
  }

  @override
  Future<void> update(
      String box, PersonalRespuestasEntity encuesta, int key) async {
    var tareas = await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');
    await tareas?.put(key, encuesta);
    await tareas.close();
    return;
  }

  @override
  Future<PersonalRespuestasEntity> migrar(String box, int key) async {
    Box<PersonalRespuestasEntity> tareas =
        await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');

    PersonalRespuestasEntity v = tareas.get(key);
    

    final AppHttpManager http = AppHttpManager();
    final res = await http.post(
      url: '$urlModule/createAll',
      body: v.toJson(),
    );
    
    
    PersonalRespuestasEntity p=PersonalRespuestasEntity.fromJson(jsonDecode(res));
    log(p.toJson().toString());
    tareas.put(key, p);
    await tareas.close();
    return p;
  }


  @override
  Future<PersonalRespuestasEntity> migrarAll(String box) async {
    Box<PersonalRespuestasEntity> tareas =
        await Hive.openBox<PersonalRespuestasEntity>('${box}_encuesta_sincronizar');

    List<PersonalRespuestasEntity> v = tareas.values.toList();
    await tareas.close();

    final AppHttpManager http = AppHttpManager();
    final res = await http.post(
      url: '$urlModule/createAll',
      body: {
        'content': v
      },
    );

    return res == null ? true : v.first;
  }

  @override
  Future<List<PersonalRespuestasEntity>> migracionMasiva(List<PersonalRespuestasEntity> detallesEnviar) async {
   
    final AppHttpManager http = AppHttpManager();
    final res = await http.post(
      url: '$urlModule/migracion',
      body: {
        'content' : List<dynamic>.from(detallesEnviar.map((x) => x.toJson()))
      },
    );

    return personalRespuestaEntityFromJson(res);
  }

  @override
  Future<PersonalRespuestasEntity> uploadFile(
      String box, PersonalRespuestasEntity encuesta, File fileLocal) async {
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
      /* PersonalRespuestasEntity respuesta = */
          PersonalRespuestasEntity.fromJson(jsonDecode(response.body));
      /* encuesta.firmasupervisor = respuesta.firmasupervisor; */
      return encuesta;
    } catch (e) {
      print('Error');
      log(e.toString());
      return null;
    }
  }
}
