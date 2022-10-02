
import 'dart:convert';
import 'package:flutter_actividades/domain/entities/detalle_respuesta_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:hive/hive.dart';

part 'respuesta_entity.g.dart';

@HiveType(typeId: 53)

class RespuestaEntity {
    RespuestaEntity({
        this.id,
        this.key,
        this.codigoempresa,
        this.detalles,
        this.fecha,
        this.hora,
        this.idencuesta,
        this.personal,
        this.idunidad,
        this.idetapa,
        this.idcampo,
        this.idturno,
        this.idpregunta,
        this.estadoLocal,
    });
    
    
    @HiveField(0)
    int key;
    @HiveField(1)
    String codigoempresa;
    @HiveField(2)
    List<DetalleRespuestaEntity> detalles;
    @HiveField(3)
    DateTime fecha;
    @HiveField(4)
    int estadoLocal;
    @HiveField(5)
    int idencuesta;
    @HiveField(6)
    PersonalEmpresaEntity personal;
    @HiveField(7)
    int idunidad;
    @HiveField(8)
    int idetapa;
    @HiveField(9)
    int idcampo;
    @HiveField(10)
    int idturno;
    @HiveField(11)
    int id;
    @HiveField(12)
    DateTime hora;
    @HiveField(13)
    int idpregunta;
    

    String getEstado(){
      switch (this.estadoLocal) {
        case -1:
          return 'Migrado pero con repetidos.';
        case 1:
          return 'Migrado con éxito.';
        case 0:
          return 'Sin migrar.';
        default:
          return 'Sin migrar.';
      }
    }

    factory RespuestaEntity.fromJson(Map<String, dynamic> json) => RespuestaEntity(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        idencuesta: json["idencuesta"] == null ? null : json["idencuesta"],
        idpregunta: json["idpregunta"] == null ? null : json["idpregunta"],
        codigoempresa: json["codigoempresa"] == null ? null : json["codigoempresa"],
        fecha: json["fecha"] == null ? null : DateTime.tryParse(json["fecha"]),
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
        personal: json["personal"] == null ? null : PersonalEmpresaEntity.fromJson(json["personal"]),
        idunidad: json["idunidad"] == null ? null : json["idunidad"],
        idetapa: json["idetapa"] == null ? null : json["idetapa"],
        idcampo: json["idcampo"] == null ? null : json["idcampo"],
        idturno: json["idturno"] == null ? null : json["idturno"],
        detalles: json['detalles'] == null
            ? []
            : List<DetalleRespuestaEntity>.from(
                json["detalles"].map((x) => DetalleRespuestaEntity?.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idpregunta": idpregunta == null ? null : idpregunta,
        "key": key == null ? null : key,
        "idencuesta": idencuesta == null ? null : idencuesta,
        "codigoempresa": codigoempresa == null ? null : codigoempresa,
        "fecha": fecha == null ? null : fecha?.toIso8601String(),
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
        "idunidad": idunidad == null ? null : idunidad,
        "idetapa": idetapa == null ? null : idetapa,
        "idcampo": idcampo == null ? null : idcampo,
        "idturno": idturno == null ? null : idturno,
        "personal": personal == null ? null : personal.toJson(),
        "detalles": detalles == null
            ? []
            : List<dynamic>.from(detalles.map((x) => x.toJson())),
    };

}

List<RespuestaEntity> respuestaEntityFromJson(String str) => List<RespuestaEntity>.from(json.decode(str).map((x) => RespuestaEntity.fromJson(x)));

String RespuestaEntityToJson(List<RespuestaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

