import 'dart:convert';
import 'package:flutter_actividades/domain/entities/encuesta_detalle_entity.dart';
import 'package:hive/hive.dart';

part 'encuesta_entity.g.dart';

@HiveType(typeId: 42)
class EncuestaEntity {
  EncuestaEntity({
    this.id,
    this.detalles,
    this.idusuario,
    this.idtipoencuesta,
    this.periodo,
    this.fechaInicio,
    this.fechaFin,
    this.titulo,
    this.descripcion,
    this.observacion,
    this.estado,
    this.createdAt,
    this.updatedAt,
    this.key,
    this.firmasupervisor,
    this.cantidadTotal,
    this.hayPendientes,
    this.anio,
  }) {
    detalles = [];
  }

  @HiveField(0)
  int id;
  @HiveField(1)
  int idusuario;
  @HiveField(2)
  int idtipoencuesta;
  @HiveField(3)
  String periodo;
  @HiveField(4)
  DateTime fechaInicio;
  @HiveField(5)
  DateTime fechaFin;
  @HiveField(6)
  String titulo;
  @HiveField(7)
  String descripcion;
  @HiveField(8)
  String observacion;
  @HiveField(10)
  String estado;
  @HiveField(11)
  DateTime createdAt;
  @HiveField(12)
  DateTime updatedAt;
  @HiveField(13)
  int key;
  @HiveField(14)
  String firmasupervisor;
  List<EncuestaDetalleEntity> detalles;
  @HiveField(15)
  int cantidadTotal;
  @HiveField(16)
  bool hayPendientes;
  @HiveField(17)
  String anio;

  get tipoEncuesta {
    switch (idtipoencuesta) {
      case 1:
        return 'Opción única.';
      case 2:
        return 'Respuesta multiple.';
      default:
        return 'Tipo no registrado';
        break;
    }
  }

  get name{
    switch(periodo?.toLowerCase()){
      case 'enero': return '01$anio';
      case 'febrero': return '02$anio';
      case 'marzo': return '03$anio';
      case 'abril': return '04$anio';
      case 'mayo': return '05$anio';
      case 'junio': return '06$anio';
      case 'julio': return '07$anio';
      case 'agosto': return '08$anio';
      case 'setiembre': return '09$anio';
      case 'octubre': return '10$anio';
      case 'noviembre': return '11$anio';
      case 'diciembre': return '12$anio';

      default:  return periodo+anio;
    }
  }

  factory EncuestaEntity.fromJson(Map<String, dynamic> json) => EncuestaEntity(
        id: json['id'] == null ? null : json["id"],
        idusuario: json['idusuario'] == null ? null : json["idusuario"],
        firmasupervisor:
            json['firmasupervisor'] == null ? null : json["firmasupervisor"],
        idtipoencuesta:
            json['idtipoencuesta'] == null ? null : json["idtipoencuesta"],
        periodo: json['periodo'] == null ? null : json["periodo"],
        fechaInicio: json['fechaInicio'] == null
            ? null
            : DateTime?.tryParse(json["fechaInicio"]),
        fechaFin: json['fechaFin'] == null
            ? null
            : DateTime?.tryParse(json["fechaFin"]),
        titulo: json['titulo'] == null ? null : json["titulo"],
        descripcion: json['descripcion'] == null ? null : json["descripcion"],
        observacion: json['observacion'] == null ? null : json["observacion"],
        estado: json['estado'] == null ? null : json["estado"],
        cantidadTotal:
            json['cantidadTotal'] == null ? null : json["cantidadTotal"],
        hayPendientes:
            json['hayPendientes'] == null ? null : json["hayPendientes"],
        key: json['key'] == null ? null : json["key"],
        anio: json['anio'] == null ? null : json["anio"],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime?.tryParse(json["createdAt"]),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime?.tryParse(json["updatedAt"]),
        detalles: json['detalles'] == null
            ? []
            : List<EncuestaDetalleEntity>.from(
                json["detalles"].map((x) => EncuestaDetalleEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idusuario": idusuario,
        "idtipoencuesta": idtipoencuesta,
        "periodo": periodo,
        "cantidadTotal": cantidadTotal,
        "hayPendientes": hayPendientes,
        "fechaInicio": fechaInicio?.toIso8601String(),
        "fechaFin": fechaFin?.toIso8601String(),
        "titulo": titulo,
        "key": key,
        "anio": anio,
        "descripcion": descripcion,
        "observacion": observacion,
        "estado": estado,
        "firmasupervisor": firmasupervisor,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "detalles": detalles == null
            ? []
            : List<dynamic>.from(detalles.map((x) => x.toJson())),
      };
}

List<EncuestaEntity> encuestaEntityFromJson(String str) =>
    List<EncuestaEntity>.from(
        json.decode(str).map((x) => EncuestaEntity.fromJson(x)));

String encuestaEntityToJson(List<EncuestaEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
