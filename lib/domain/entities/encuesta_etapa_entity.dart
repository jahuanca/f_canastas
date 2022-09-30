// To parse this JSON data, do
//
//     final encuestaEtapaEntity = encuestaEtapaEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_actividades/domain/entities/encuesta_campo_entity.dart';
import 'package:hive/hive.dart';

part 'encuesta_etapa_entity.g.dart';

@HiveType(typeId: 55)

class EncuestaEtapaEntity {
    EncuestaEtapaEntity({
        this.idetapa,
        this.etapa,
        this.descripcion,
        this.encuestaCampos,
    });

    @HiveField(0)
    int idetapa;
    @HiveField(1)
    String etapa;
    @HiveField(2)
    String descripcion;
    List<EncuestaCampoEntity> encuestaCampos;

    factory EncuestaEtapaEntity.fromJson(Map<String, dynamic> json) => EncuestaEtapaEntity(
        idetapa: json["idetapa"] == null ? null : json["idetapa"],
        etapa: json["etapa"] == null ? null : json["etapa"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        encuestaCampos: json["encuesta_campos"] == null ? null : List<EncuestaCampoEntity>.from(json["encuesta_campos"].map((x) => EncuestaCampoEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idetapa": idetapa == null ? null : idetapa,
        "etapa": etapa == null ? null : etapa,
        "descripcion": descripcion == null ? null : descripcion,
        "encuesta_campos": encuestaCampos == null ? null : List<dynamic>.from(encuestaCampos.map((x) => x.toJson())),
    };
}

List<EncuestaEtapaEntity> encuestaEtapaEntityFromJson(String str) => List<EncuestaEtapaEntity>.from(json.decode(str).map((x) => EncuestaEtapaEntity.fromJson(x)));

String encuestaEtapaEntityToJson(List<EncuestaEtapaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
