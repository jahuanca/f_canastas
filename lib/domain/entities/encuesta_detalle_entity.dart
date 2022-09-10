
import 'dart:convert';
import 'package:flutter_actividades/domain/entities/encuesta_opciones_entity.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:hive/hive.dart';

part 'encuesta_detalle_entity.g.dart';

@HiveType(typeId: 44)

class EncuestaDetalleEntity {
    EncuestaDetalleEntity({
        this.id,
        this.idencuesta,
        this.idusuario,
        this.descripcion,
        this.observacion,
        this.estado,
        this.createdAt,
        this.updatedAt,
        this.codigoempresa,
        this.fecha,
        this.hora,
        this.idopcionencuesta,
        this.idsubdivision,
        this.opcionmanual,
        this.personal,
        this.opcionEncuesta,
        this.key,
        this.estadoLocal,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idencuesta;
    @HiveField(2)
    int idusuario;
    @HiveField(3)
    String codigoempresa;
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
    @HiveField(9)
    String opcionmanual;
    @HiveField(10)
    DateTime fecha;
    @HiveField(11)
    DateTime hora;
    @HiveField(12)
    int idsubdivision;
    @HiveField(13)
    int idopcionencuesta;
    @HiveField(14)
    PersonalEmpresaEntity personal;
    @HiveField(15)
    EncuestaOpcionesEntity opcionEncuesta;
    @HiveField(16)
    int key;
    @HiveField(17)
    int estadoLocal;

    factory EncuestaDetalleEntity.fromJson(Map<String, dynamic> json) => EncuestaDetalleEntity(
        id: json['id'] == null ? null : json["id"],
        key: json['key'] == null ? null : json["key"],
        idencuesta: json['idencuesta'] == null ? null : json["idencuesta"],
        idusuario: json['idusuario'] == null ? null : json["idusuario"],
        idopcionencuesta: json['idopcionencuesta'] == null ? null : json["idopcionencuesta"],
        codigoempresa: json['codigoempresa'] == null ? null : json["codigoempresa"],
        fecha: json['fecha'] == null ? null : DateTime.tryParse(json["fecha"]),
        hora: json['hora'] == null ? null : DateTime.tryParse(json["hora"]),
        opcionmanual: json['opcionmanual'] == null ? null : json["opcionmanual"],
        idsubdivision: json['idsubdivision'] == null ? null : json["idsubdivision"],
        descripcion: json['descripcion'] == null ? null : json["descripcion"],
        observacion: json['observacion'] == null ? null : json["observacion"],
        estado: json['estado'] == null ? null : json["estado"],
        opcionEncuesta: json["opcion_encuesta"] == null
            ? null
            : EncuestaOpcionesEntity.fromJson(
                json["opcion_encuesta"]),
        personal: json["Personal"] == null
            ? null
            : PersonalEmpresaEntity.fromJson(
                json["Personal"]),
        createdAt: json['createdAt'] == null ? null : DateTime.tryParse(json["createdAt"]),
        updatedAt: json['updatedAt'] == null ? null : DateTime.tryParse(json["updatedAt"]),
        estadoLocal: json['estadoLocal'] == null ? null : json["estadoLocal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idencuesta": idencuesta,
        "key": key,
        "idusuario": idusuario,
        "estadoLocal": estadoLocal,
        "opcionmanual": opcionmanual,
        "fecha": fecha?.toIso8601String(),
        "hora": hora?.toIso8601String(),
        "idsubdivision": idsubdivision,
        "idopcionencuesta": idopcionencuesta,
        "codigoempresa": codigoempresa,
        "descripcion": descripcion,
        "observacion": observacion,
        "estado": estado,
        "personal": personal?.toJson(),
        "opcion_encuesta": opcionEncuesta?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

List<EncuestaDetalleEntity> encuestaDetalleEntityFromJson(String str) => List<EncuestaDetalleEntity>.from(json.decode(str).map((x) => EncuestaDetalleEntity.fromJson(x)));

String encuestaDetalleEntityToJson(List<EncuestaDetalleEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));