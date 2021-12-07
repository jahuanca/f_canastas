// To parse this JSON data, do
//
//     final vehiculoEntity = vehiculoEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'vehiculo_entity.g.dart';

@HiveType(typeId: 35)

class VehiculoEntity {
    VehiculoEntity({
        this.id,
        this.placa,
        this.modelo,
        this.fechamod,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    String placa;
    @HiveField(2)
    String modelo;
    @HiveField(3)
    DateTime fechamod;

    factory VehiculoEntity.fromJson(Map<String, dynamic> json) => VehiculoEntity(
        id: json["id"] == null ? null : json["id"],
        placa: json["placa"] == null ? null : json["placa"],
        modelo: json["modelo"] == null ? null : json["modelo"],
        fechamod: json["fechamod"] == null ? null : DateTime.parse(json["fechamod"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "placa": placa == null ? null : placa,
        "modelo": modelo == null ? null : modelo,
        "fechamod": fechamod == null ? null : fechamod.toIso8601String(),
    };
}

List<VehiculoEntity> vehiculoEntityFromJson(String str) => List<VehiculoEntity>.from(json.decode(str).map((x) => VehiculoEntity.fromJson(x)));

String vehiculoEntityToJson(List<VehiculoEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
