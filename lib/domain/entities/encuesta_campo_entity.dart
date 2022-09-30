// To parse this JSON data, do
//
//     final encuestaCampoEntity = encuestaCampoEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_actividades/domain/entities/encuesta_turno_entity.dart';
import 'package:hive/hive.dart';

part 'encuesta_campo_entity.g.dart';

@HiveType(typeId: 56)

class EncuestaCampoEntity {
    EncuestaCampoEntity({
        this.idcampo,
        this.campo,
        this.descripcion,
        this.idetapa,
        this.encuestaTurnos,
    });

    @HiveField(0)
    int idcampo;
    @HiveField(1)
    String campo;
    @HiveField(2)
    String descripcion;
    @HiveField(3)
    int idetapa;
    
    List<EncuestaTurnoEntity> encuestaTurnos;

    factory EncuestaCampoEntity.fromJson(Map<String, dynamic> json) => EncuestaCampoEntity(
        idcampo: json["idcampo"] == null ? null : json["idcampo"],
        campo: json["campo"] == null ? null : json["campo"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        idetapa: json["idetapa"] == null ? null : json["idetapa"],
        encuestaTurnos: json["encuesta_turnos"] == null ? null : List<EncuestaTurnoEntity>.from(json["encuesta_turnos"].map((x) => EncuestaTurnoEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idcampo": idcampo == null ? null : idcampo,
        "campo": campo == null ? null : campo,
        "descripcion": descripcion == null ? null : descripcion,
        "idetapa": idetapa == null ? null : idetapa,
        "encuesta_turnos": encuestaTurnos == null ? null : List<dynamic>.from(encuestaTurnos.map((x) => x.toJson())),
    };
}

List<EncuestaCampoEntity> encuestaCampoEntityFromJson(String str) => List<EncuestaCampoEntity>.from(json.decode(str).map((x) => EncuestaCampoEntity.fromJson(x)));

String encuestaCampoEntityToJson(List<EncuestaCampoEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));