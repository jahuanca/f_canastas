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
        this.indexesSelected,
        this.estadoLocal,
        this.idRespuestaDB,
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
    @HiveField(12)
    List<int> indexesSelected;
    String opcionManual;
    int estadoLocal;
    int idRespuestaDB;

    String tipoPregunta(){
      switch (this.idtipopregunta) {
        case 1: return 'Respuesta múltiple.';
        case 2: return 'Respuesta única.';
        default:  return 'Sin tipo';
      } 
    }

    factory PreguntaEntity.fromJson(Map<String, dynamic> json) => PreguntaEntity(
        id: json["id"] == null ? null : json["id"],
        idRespuestaDB: json["idRespuestaDB"] == null ? null : json["idRespuestaDB"],
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        idencuesta: json["idencuesta"] == null ? null : json["idencuesta"],
        idtipopregunta: json["idtipopregunta"] == null ? null : json["idtipopregunta"],
        pregunta: json["pregunta"] == null ? null : json["pregunta"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        observacion: json["observacion"] == null ? null : json["observacion"],
        estado: json["estado"] == null ? null : json["estado"],
        indexesSelected: json["indexesSelected"] == null ? [] : List<int>.from(json["indexesSelected"].map((x)=> x)),
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
        "idRespuestaDB": idRespuestaDB == null ? null : idRespuestaDB,
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
        "idusuario": idusuario == null ? null : idusuario,
        "idencuesta": idencuesta == null ? null : idencuesta,
        "idtipopregunta": idtipopregunta == null ? null : idtipopregunta,
        "pregunta": pregunta == null ? null : pregunta,
        "descripcion": descripcion == null ? null : descripcion,
        "observacion": observacion == null ? null : observacion,
        "estado": estado == null ? null : estado,
        "indexesSelected": indexesSelected == null ? [] : List<dynamic>.from(indexesSelected.map((e) => e)),
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
