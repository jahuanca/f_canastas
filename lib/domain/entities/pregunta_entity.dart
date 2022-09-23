// To parse this JSON data, do
//
//     final preguntaEntity = preguntaEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_actividades/domain/entities/opcion_entity.dart';
import 'package:hive/hive.dart';

part 'pregunta_entity.g.dart';

@HiveType(typeId: 50)

class PreguntaEntity {
    PreguntaEntity({
        this.id,
        this.idusuario,
        this.idencuesta,
        this.idtipopregunta,
        this.pregunta,
        this.descripcion,
        this.observacion,
        this.estado,
        this.permitirOpcionManual,
        this.createdAt,
        this.updatedAt,
        this.opciones,
        this.indexSelected,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idusuario;
    @HiveField(2)
    int idencuesta;
    @HiveField(3)
    int idtipopregunta;
    @HiveField(4)
    String pregunta;
    @HiveField(5)
    String descripcion;
    @HiveField(6)
    String observacion;
    @HiveField(7)
    String estado;
    @HiveField(8)
    bool permitirOpcionManual;
    @HiveField(9)
    DateTime createdAt;
    @HiveField(10)
    DateTime updatedAt;
    @HiveField(11)
    List<OpcionEntity> opciones;
    int indexSelected;
    String opcionManual;

    factory PreguntaEntity.fromJson(Map<String, dynamic> json) => PreguntaEntity(
        id: json["id"] == null ? null : json["id"],
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        idencuesta: json["idencuesta"] == null ? null : json["idencuesta"],
        idtipopregunta: json["idtipopregunta"] == null ? null : json["idtipopregunta"],
        pregunta: json["pregunta"] == null ? null : json["pregunta"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        observacion: json["observacion"] == null ? null : json["observacion"],
        estado: json["estado"] == null ? null : json["estado"],
        indexSelected: json["indexSelected"] == null ? null : json["indexSelected"],
        permitirOpcionManual: json["permitirOpcionManual"] == null ? null : json["permitirOpcionManual"],
        createdAt: json["createdAt"] == null ? null : DateTime?.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime?.tryParse(json["updatedAt"]),
        opciones: json['Opcions'] == null
            ? []
            : List<OpcionEntity>.from(
                json["Opcions"].map((x) => OpcionEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idusuario": idusuario == null ? null : idusuario,
        "idencuesta": idencuesta == null ? null : idencuesta,
        "idtipopregunta": idtipopregunta == null ? null : idtipopregunta,
        "pregunta": pregunta == null ? null : pregunta,
        "descripcion": descripcion == null ? null : descripcion,
        "observacion": observacion == null ? null : observacion,
        "estado": estado == null ? null : estado,
        "indexSelected": indexSelected == null ? null : indexSelected,
        "permitirOpcionManual": permitirOpcionManual == null ? null : permitirOpcionManual,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "Opcions": opciones == null
            ? []
            : List<dynamic>.from(opciones.map((x) => x.toJson())),
    };

    List<PreguntaEntity> preguntaEntityFromJson(String str) => List<PreguntaEntity>.from(json.decode(str).map((x) => PreguntaEntity.fromJson(x)));

    String preguntaEntityToJson(List<PreguntaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}