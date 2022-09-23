// To parse this JSON data, do
//
//     final opcionEntity = opcionEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'opcion_entity.g.dart';

@HiveType(typeId: 51)

class OpcionEntity {
    OpcionEntity({
        this.id,
        this.idusuario,
        this.idpregunta,
        this.opcion,
        this.descripcion,
        this.observacion,
        this.estado,
        this.createdAt,
        this.updatedAt,
        this.seleccionada,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idusuario;
    @HiveField(2)
    int idpregunta;
    @HiveField(3)
    String opcion;
    @HiveField(4)
    String descripcion;
    @HiveField(5)
    String observacion;
    @HiveField(6)
    String estado;
    @HiveField(7)
    DateTime createdAt;
    @HiveField(8)
    DateTime updatedAt;
    bool seleccionada;

    factory OpcionEntity.fromJson(Map<String, dynamic> json) => OpcionEntity(
        id: json["id"] == null ? null : json["id"],
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        idpregunta: json["idpregunta"] == null ? null : json["idpregunta"],
        opcion: json["opcion"] == null ? null : json["opcion"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        observacion: json["observacion"] == null ? null : json["observacion"],
        estado: json["estado"] == null ? null : json["estado"],
        seleccionada: json["seleccionada"] == null ? null : json["seleccionada"],
        createdAt: json["createdAt"] == null ? null : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.tryParse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idusuario": idusuario == null ? null : idusuario,
        "idpregunta": idpregunta == null ? null : idpregunta,
        "opcion": opcion == null ? null : opcion,
        "descripcion": descripcion == null ? null : descripcion,
        "observacion": observacion == null ? null : observacion,
        "estado": estado == null ? null : estado,
        "seleccionada": seleccionada == null ? null : seleccionada,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };

    List<OpcionEntity> opcionEntityFromJson(String str) => List<OpcionEntity>.from(json.decode(str).map((x) => OpcionEntity.fromJson(x)));

    String opcionEntityToJson(List<OpcionEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

