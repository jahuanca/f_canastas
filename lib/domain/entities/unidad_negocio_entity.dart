// To parse this JSON data, do
//
//     final unidadNegocioEntity = unidadNegocioEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'unidad_negocio_entity.g.dart';

@HiveType(typeId: 54)
class UnidadNegocioEntity {
    UnidadNegocioEntity({
        this.idunidad,
        this.descripcion,
        this.grupo,
        this.sociedad,
    });

    
    @HiveField(0)
    int idunidad;
    @HiveField(1)
    String descripcion;
    @HiveField(2)
    String grupo;
    @HiveField(3)
    String sociedad;

    factory UnidadNegocioEntity.fromJson(Map<String, dynamic> json) => UnidadNegocioEntity(
        idunidad: json["idunidad"] == null ? null : json["idunidad"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        grupo: json["grupo"] == null ? null : json["grupo"],
        sociedad: json["sociedad"] == null ? null : json["sociedad"],
    );

    Map<String, dynamic> toJson() => {
        "idunidad": idunidad == null ? null : idunidad,
        "descripcion": descripcion == null ? null : descripcion,
        "grupo": grupo == null ? null : grupo,
        "sociedad": sociedad == null ? null : sociedad,
    };
}

List<UnidadNegocioEntity> unidadNegocioEntityFromJson(String str) => List<UnidadNegocioEntity>.from(json.decode(str).map((x) => UnidadNegocioEntity.fromJson(x)));

String unidadNegocioEntityToJson(List<UnidadNegocioEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));