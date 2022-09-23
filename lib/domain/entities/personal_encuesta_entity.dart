// To parse this JSON data, do
//
//     final PersonalEncuestaEntity = PersonalEncuestaEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/respuesta_entity.dart';
import 'package:hive/hive.dart';

part 'personal_encuesta_entity.g.dart';

@HiveType(typeId: 53)

class PersonalEncuestaEntity {
    PersonalEncuestaEntity({
        this.key,
        this.codigoempresa,
        this.respuestas,
        this.estadoLocal,
        this.fecha,
        this.idencuesta,
        this.personal,
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

    factory PersonalEncuestaEntity.fromJson(Map<String, dynamic> json) => PersonalEncuestaEntity(
        key: json["key"] == null ? null : json["key"],
        idencuesta: json["idencuesta"] == null ? null : json["idencuesta"],
        codigoempresa: json["codigoempresa"] == null ? null : json["codigoempresa"],
        fecha: json["fecha"] == null ? null : DateTime.tryParse(json["fecha"]),
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
        personal: json["personal"] == null ? null : json["personal"],
        respuestas: json['respuestas'] == null
            ? []
            : List<RespuestaEntity>.from(
                json["respuestas"].map((x) => RespuestaEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "idencuesta": idencuesta == null ? null : idencuesta,
        "codigoempresa": codigoempresa == null ? null : codigoempresa,
        "fecha": fecha == null ? null : fecha?.toIso8601String(),
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
        "personal": personal == null ? null : personal.toJson(),
        "respuesta": respuestas == null
            ? []
            : List<dynamic>.from(respuestas.map((x) => x.toJson())),
    };

    List<PersonalEncuestaEntity> personalEncuestaEntityFromJson(String str) => List<PersonalEncuestaEntity>.from(json.decode(str).map((x) => PersonalEncuestaEntity.fromJson(x)));

    String PersonalEncuestaEntityToJson(List<PersonalEncuestaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

