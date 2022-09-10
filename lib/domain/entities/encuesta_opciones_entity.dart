
import 'dart:convert';
import 'package:hive/hive.dart';

part 'encuesta_opciones_entity.g.dart';

@HiveType(typeId: 43)

class EncuestaOpcionesEntity {
    EncuestaOpcionesEntity({
        this.id,
        this.idencuesta,
        this.idusuario,
        this.opcion,
        this.descripcion,
        this.observacion,
        this.estado,
        this.createdAt,
        this.updatedAt,
        this.cantidad,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idencuesta;
    @HiveField(2)
    int idusuario;
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
    int cantidad;

    factory EncuestaOpcionesEntity.fromJson(Map<String, dynamic> json) => EncuestaOpcionesEntity(
        id: json["id"],
        idencuesta: json["idencuesta"],
        idusuario: json["idusuario"],
        opcion: json["opcion"],
        cantidad: json["cantidad"],
        descripcion: json["descripcion"],
        observacion: json["observacion"],
        estado: json["estado"],
        createdAt: json['createdAt'] == null ? null : DateTime.tryParse(json["createdAt"]),
        updatedAt: json['updatedAt'] == null ? null : DateTime.tryParse(json["updatedAt"]),
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idencuesta": idencuesta,
        "idusuario": idusuario,
        "cantidad": cantidad,
        "opcion": opcion,
        "descripcion": descripcion,
        "observacion": observacion,
        "estado": estado,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

List<EncuestaOpcionesEntity> encuestaOpcionesEntityFromJson(String str) => List<EncuestaOpcionesEntity>.from(json.decode(str).map((x) => EncuestaOpcionesEntity.fromJson(x)));

String encuestaOpcionesEntityToJson(List<EncuestaOpcionesEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));