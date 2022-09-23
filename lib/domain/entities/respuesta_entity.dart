import 'dart:convert';

import 'package:hive/hive.dart';

part 'respuesta_entity.g.dart';

@HiveType(typeId: 52)
class RespuestaEntity{


  RespuestaEntity({
    this.id,
    this.idsubdivision,
    this.idusuario,
    this.idencuesta,
    this.idpregunta,
    this.idopcion,
    this.codigoempresa,
    this.opcionmanual,
    this.fecha,
    this.hora,
    this.descripcion,
    this.observacion,
    this.estado,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  int idsubdivision;
  @HiveField(2)
  int idusuario;
  @HiveField(3)
  int idencuesta;
  @HiveField(4)
  int idpregunta;
  @HiveField(5)
  int idopcion;
  @HiveField(6)
  String codigoempresa;
  @HiveField(7)
  String opcionmanual;
  @HiveField(8)
  DateTime fecha;
  @HiveField(9)
  DateTime hora;
  @HiveField(10)
  String descripcion;
  @HiveField(11)
  String observacion;
  @HiveField(12)
  String estado;

  factory RespuestaEntity.fromJson(Map<String, dynamic> json) => RespuestaEntity(
        id: json["id"]== null ? null : json["id"],
        idsubdivision: json["idsubdivision"]== null ? null : json["idsubdivision"],
        idusuario: json["idusuario"]== null ? null : json["idusuario"],
        idencuesta: json["idencuesta"]== null ? null : json["idencuesta"],
        idpregunta: json["idpregunta"]== null ? null : json["idpregunta"],
        idopcion: json["idopcion"]== null ? null : json["idopcion"],
        codigoempresa: json["codigoempresa"]== null ? null : json["codigoempresa"],
        opcionmanual: json["opcionmanual"]== null ? null : json["opcionmanual"],
        fecha: json["fecha"]== null ? null : json["fecha"],
        hora: json["hora"]== null ? null : json["hora"],
        descripcion: json["descripcion"]== null ? null : json["descripcion"],
        observacion: json["observacion"]== null ? null : json["observacion"],
        estado: json["estado"]== null ? null : json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idsubdivision": idsubdivision == null ? null : idsubdivision,
        "idusuario": idusuario == null ? null : idusuario,
        "idencuesta": idencuesta == null ? null : idencuesta,
        "idpregunta": idpregunta == null ? null : idpregunta,
        "idopcion": idopcion == null ? null : idopcion,
        "codigoempresa": codigoempresa == null ? null : codigoempresa,
        "opcionmanual": opcionmanual == null ? null : opcionmanual,
        "fecha": fecha == null ? null : fecha,
        "hora": hora == null ? null : hora,
        "descripcion": descripcion == null ? null : descripcion,
        "observacion": observacion == null ? null : observacion,
        "estado": estado == null ? null : estado,
    };

    List<RespuestaEntity> respuestaEntityFromJson(String str) => List<RespuestaEntity>.from(json.decode(str).map((x) => RespuestaEntity.fromJson(x)));

    String RespuestaEntityToJson(List<RespuestaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  
}