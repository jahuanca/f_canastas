// To parse this JSON data, do
//
//     final encuestaTurnoEntity = encuestaTurnoEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'encuesta_turno_entity.g.dart';

@HiveType(typeId: 57)
class EncuestaTurnoEntity {
    EncuestaTurnoEntity({
        this.idturno,
        this.turno,
        this.descripcion,
        this.idcampo,
        this.idetapa,
    });

    @HiveField(0)
    int idturno;
    @HiveField(1)
    String turno;
    @HiveField(2)
    String descripcion;
    @HiveField(3)
    int idcampo;
    @HiveField(4)
    int idetapa;

    factory EncuestaTurnoEntity.fromJson(Map<String, dynamic> json) => EncuestaTurnoEntity(
        idturno: json["idturno"] == null ? null : json["idturno"],
        turno: json["turno"] == null ? null : json["turno"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        idcampo: json["idcampo"] == null ? null : json["idcampo"],
        idetapa: json["idetapa"] == null ? null : json["idetapa"],
    );

    Map<String, dynamic> toJson() => {
        "idturno": idturno == null ? null : idturno,
        "turno": turno == null ? null : turno,
        "descripcion": descripcion == null ? null : descripcion,
        "idcampo": idcampo == null ? null : idcampo,
        "idetapa": idetapa == null ? null : idetapa,
    };
}
List<EncuestaTurnoEntity> encuestaTurnoEntityFromJson(String str) => List<EncuestaTurnoEntity>.from(json.decode(str).map((x) => EncuestaTurnoEntity.fromJson(x)));

String encuestaTurnoEntityToJson(List<EncuestaTurnoEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));