// To parse this JSON data, do
//
//     final productoEntity = productoEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'producto_entity.g.dart';

@HiveType(typeId: 37)

class ProductoEntity {
    ProductoEntity({
        this.id,
        this.descripcion,
        this.unidad,
        this.fechamod,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    String descripcion;
    @HiveField(2)
    String unidad;
    @HiveField(3)
    DateTime fechamod;

    factory ProductoEntity.fromJson(Map<String, dynamic> json) => ProductoEntity(
        id: json["id"] == null ? null : json["id"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        unidad: json["unidad"] == null ? null : json["unidad"],
        fechamod: json["fechamod"] == null ? null : DateTime.parse(json["fechamod"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "descripcion": descripcion == null ? null : descripcion,
        "unidad": unidad == null ? null : unidad,
        "fechamod": fechamod == null ? null : fechamod.toIso8601String(),
    };
}

List<ProductoEntity> productoEntityFromJson(String str) => List<ProductoEntity>.from(json.decode(str).map((x) => ProductoEntity.fromJson(x)));

String productoEntityToJson(List<ProductoEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
