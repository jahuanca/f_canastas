import 'dart:convert';

import 'package:hive/hive.dart';

part 'detalle_respuesta_entity.g.dart';

@HiveType(typeId: 52)
class DetalleRespuestaEntity {
  DetalleRespuestaEntity({
    this.id,
    this.idusuario,
    this.idopcion,
    this.opcionmanual,
    this.fecha,
    this.hora,
    this.descripcion,
    this.observacion,
    this.estado,
    this.estadoLocal,
    this.idrespuesta,
    this.keyRespuesta,
  });

  @HiveField(0)
  int id;
  @HiveField(2)
  int idusuario;
  @HiveField(3)
  int idopcion;
  @HiveField(4)
  String codigoempresa;
  @HiveField(5)
  DateTime fecha;
  @HiveField(6)
  DateTime hora;
  @HiveField(7)
  String descripcion;
  @HiveField(8)
  String observacion;
  @HiveField(9)
  String estado;
  @HiveField(10)
  int estadoLocal;
  @HiveField(11)
  String opcionmanual;
  @HiveField(12)
  int idrespuesta;
  @HiveField(13)
  int keyRespuesta;


  factory DetalleRespuestaEntity.fromJson(Map<String, dynamic> json) =>
      DetalleRespuestaEntity(
        id: json["id"] == null ? null : json["id"],
        idrespuesta: json["idrespuesta"] == null ? null : json["idrespuesta"],
        keyRespuesta: json["keyRespuesta"] == null ? null : json["keyRespuesta"],
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        idopcion: json["idopcion"] == null ? null : json["idopcion"],
        opcionmanual: json["opcionmanual"] == null ? null : json["opcionmanual"],
        fecha: json["fecha"] == null ? null : DateTime?.tryParse(json["fecha"]),
        hora: json["hora"] == null ? null : DateTime?.tryParse(json["hora"]),
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        observacion: json["observacion"] == null ? null : json["observacion"],
        estado: json["estado"] == null ? null : json["estado"],
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idusuario": idusuario == null ? null : idusuario,
        "idrespuesta": idrespuesta == null ? null : idrespuesta,
        "keyRespuesta": keyRespuesta == null ? null : keyRespuesta,
        "idopcion": idopcion == null ? null : idopcion,
        "opcionmanual": opcionmanual == null ? null : opcionmanual,
        "codigoempresa": codigoempresa == null ? null : codigoempresa,
        "fecha": fecha == null ? null : fecha?.toIso8601String(),
        "hora": hora == null ? null : hora?.toIso8601String(),
        "descripcion": descripcion == null ? null : descripcion,
        "observacion": observacion == null ? null : observacion,
        "estado": estado == null ? null : estado,
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
      };
}

List<DetalleRespuestaEntity> respuestaEntityFromJson(String str) =>
    List<DetalleRespuestaEntity>.from(
        json.decode(str).map((x) => DetalleRespuestaEntity.fromJson(x)));

String respuestaEntityToJson(List<DetalleRespuestaEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
