// To parse this JSON data, do
//
//     final puntoEntregaEntity = puntoEntregaEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'punto_entrega_entity.g.dart';

@HiveType(typeId: 41)


class PuntoEntregaEntity {
    PuntoEntregaEntity({
        this.id,
        this.nombre,
        this.descripcion,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    String nombre;
    @HiveField(2)
    String descripcion;

    factory PuntoEntregaEntity.fromJson(Map<String, dynamic> json) => PuntoEntregaEntity(
        id: json["id"] == null ? null : (json["id"] as num),
        nombre: json["nombre"] == null ? null : json["nombre"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombre": nombre == null ? null : nombre,
        "descripcion": descripcion == null ? null : descripcion,
    };
}

List<PuntoEntregaEntity> puntoEntregaEntityFromJson(String str) => List<PuntoEntregaEntity>.from(json.decode(str).map((x) => PuntoEntregaEntity.fromJson(x)));

String puntoEntregaEntityToJson(List<PuntoEntregaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));