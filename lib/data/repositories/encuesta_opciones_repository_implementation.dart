import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/repositories/encuesta_opciones_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class EncuestaOpcionesRepositoryImplementation extends EncuestaOpcionesRepository {
  final urlModule = '/encuesta_opciones';

  @override
  Future<List<EncuestaOpcionesEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box<EncuestaOpcionesEntity> dataHive =
          await Hive.openBox<EncuestaOpcionesEntity>('encuesta_opciones_sincronizar');
      List<EncuestaOpcionesEntity> local = [];
      
      local.addAll(dataHive.values);
      
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return encuestaOpcionesEntityFromJson((res));
  }

  @override
  Future<List<EncuestaOpcionesEntity>> getAllByValue(
      Map<String, dynamic> valores) async {
    if (PreferenciasUsuario().offLine) {
      Box<EncuestaOpcionesEntity> dataHive =
          await Hive.openBox<EncuestaOpcionesEntity>('encuesta_opciones_sincronizar');
      List<EncuestaOpcionesEntity> local = [];

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
  Future<void> update(EncuestaOpcionesEntity EncuestaOpciones) async {
    Box<EncuestaOpcionesEntity> dataHive =
        await Hive.openBox<EncuestaOpcionesEntity>('encuesta_opciones_sincronizar');
    int keyObtenido = -1;

    for (var i = 0; i < dataHive.keys.length; i++) {
      var k=dataHive.keys.elementAt(i);
      var v=dataHive.get(k);
      /* if(v.id == EncuestaOpciones.id && (v.sizeVehiculos != EncuestaOpciones.sizeVehiculos || v.sizePersonalRegistrados != EncuestaOpciones.sizePersonalRegistrados)){
        keyObtenido=k;
        break;
      } */
    }
    
    if (keyObtenido != -1) {
      await dataHive.put(keyObtenido, EncuestaOpciones);
    }
    await dataHive.close();
    return;
  }
}
