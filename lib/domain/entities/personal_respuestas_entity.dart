import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:hive/hive.dart';

part 'personal_respuestas_entity.g.dart';

@HiveType(typeId: 58)
class PersonalRespuestasEntity {
  PersonalRespuestasEntity({
    this.id,
    this.key,
    this.codigoempresa,
    this.idencuesta,
    this.personal,
    this.respuestas,
    this.fecha,
    this.hora,
    this.estadoLocal,
    this.estado,
    this.idunidad,
    this.idetapa,
    this.idcampo,
    this.idturno,
  });

  @HiveField(0)
  int key;
  @HiveField(1)
  String codigoempresa;
  @HiveField(2)
  List<RespuestaEntity> respuestas;
  @HiveField(3)
  DateTime fecha;
  @HiveField(4)
  int estadoLocal;
  @HiveField(5)
  int idencuesta;
  @HiveField(6)
  PersonalEmpresaEntity personal;
  @HiveField(7)
  int id;
  @HiveField(8)
  DateTime hora;
  @HiveField(9)
  String estado;
  @HiveField(10)
  int idunidad;
  @HiveField(11)
  int idetapa;
  @HiveField(12)
  int idcampo;
  @HiveField(13)
  int idturno;


  Widget _containerIcon(String text, IconData icon, Color color){
    return Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 5 ),
              child:CircleAvatar(
                radius: 10,
                backgroundColor: color,
                child: Icon(
                icon,
                color: Colors.white,
                size: 15,
            ),
              ),
            ),
            Text(text,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                )),
          ],
        );
  }

  Widget getEstadoIcon() {

    bool pendiente=this.getPendientesPorMigrar();

    switch (this.estadoLocal) {
      case -1:
        return _containerIcon(
          pendiente ? 'Pendientes y repetidos' :'Migrado pero con repetidos',
          Icons.error,
          alertColor
        );
      case 1:
        return _containerIcon(
          pendiente ? 'Migrado pero con pendientes' : 'Migrado con éxito',
          pendiente ? Icons.close : Icons.check_outlined, 
          pendiente ? dangerColor : infoColor
        );
      case 0:
        return _containerIcon('Sin migrar', Icons.error, dangerColor);
      default:
        return Row(
          children: [
            Icon(
              Icons.align_vertical_bottom_rounded,
            ),
            Text('Sin migrar'),
          ],
        );
    }
  }

  /* String getEstado() {
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
  } */

  bool getPendientesPorMigrar() {
    for (RespuestaEntity r in this.respuestas) {
      if (r.id == null) {
        return true;
      }
    }

    return false;
  }

  factory PersonalRespuestasEntity.fromJson(Map<String, dynamic> json) =>
      PersonalRespuestasEntity(
        id: json["id"] == null ? null : json["id"],
        idunidad: json["idunidad"] == null ? null : json["idunidad"],
        idetapa: json["idetapa"] == null ? null : json["idetapa"],
        idcampo: json["idcampo"] == null ? null : json["idcampo"],
        idturno: json["idturno"] == null ? null : json["idturno"],
        key: json["key"] == null ? null : json["key"],
        idencuesta: json["idencuesta"] == null ? null : json["idencuesta"],
        codigoempresa:
            json["codigoempresa"] == null ? null : json["codigoempresa"],
        fecha: json["fecha"] == null ? null : DateTime.tryParse(json["fecha"]),
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
        personal: json["personal"] == null
            ? null
            : PersonalEmpresaEntity.fromJson(json["personal"]),
        respuestas: json['respuestas'] == null
            ? []
            : List<RespuestaEntity>.from(
                json["respuestas"].map((x) => RespuestaEntity?.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idunidad": idunidad == null ? null : idunidad,
        "idetapa": idetapa == null ? null : idetapa,
        "idcampo": idcampo == null ? null : idcampo,
        "idturno": idturno == null ? null : idturno,
        "key": key == null ? null : key,
        "idencuesta": idencuesta == null ? null : idencuesta,
        "codigoempresa": codigoempresa == null ? null : codigoempresa,
        "fecha": fecha == null ? null : fecha?.toIso8601String(),
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
        "personal": personal == null ? null : personal?.toJson(),
        "respuestas": respuestas == null
            ? []
            : List<dynamic>.from(respuestas.map((x) => x.toJson())),
      };
}

List<PersonalRespuestasEntity> personalRespuestaEntityFromJson(String str) =>
    List<PersonalRespuestasEntity>.from(
        json.decode(str).map((x) => PersonalRespuestasEntity.fromJson(x)));

String PersonalRespuestasEntityToJson(List<PersonalRespuestasEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
