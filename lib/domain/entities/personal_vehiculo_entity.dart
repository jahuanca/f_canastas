// To parse this JSON data, do
//
//     final vehiculoEntity = vehiculoEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:hive/hive.dart';

part 'personal_vehiculo_entity.g.dart';

@HiveType(typeId: 40)

class PersonalVehiculoEntity {
    PersonalVehiculoEntity({
        this.id,
        this.idvehiculotemporada,
        this.idusuario,
        this.codigosap,
        this.fecha,
        this.hora,
        this.apto,
        this.personal,
        this.idpuntoentrega,
        this.key,
        this.nrodocumento,
        this.idtemporada,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idvehiculotemporada;
    @HiveField(2)
    int idusuario;
    @HiveField(3)
    String codigosap;
    @HiveField(4)
    DateTime fecha;
    @HiveField(5)
    DateTime hora;
    @HiveField(6)
    bool apto;
    @HiveField(7)
    PersonalEmpresaEntity personal;
    @HiveField(8)
    int idpuntoentrega;
    @HiveField(9)
    int key;
    @HiveField(10)
    String nrodocumento;
    @HiveField(11)
    int idtemporada;

    factory PersonalVehiculoEntity.fromJson(Map<String, dynamic> json) => PersonalVehiculoEntity(
        id: json["id"] == null ? null : (json["id"] as num),
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        idvehiculotemporada: json["idvehiculotemporada"] == null ? null : (json["idvehiculotemporada"] as num),
        codigosap: json["codigosap"] == null ? null : json["codigosap"],
        nrodocumento: json["nrodocumento"] == null ? null : json["nrodocumento"],
        apto: json["apto"] == null ? null : json["apto"],
        key: json["key"] == null ? null : json["key"],
        idtemporada: json["idtemporada"] == null ? null : json["idtemporada"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        hora: json["hora"] == null ? null : DateTime.parse(json["hora"]),
        idpuntoentrega: json["idpuntoentrega"] == null ? null : json["idpuntoentrega"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idusuario": idusuario == null ? null : idusuario,
        "idvehiculotemporada": idvehiculotemporada == null ? null : idvehiculotemporada,
        "codigosap": codigosap == null ? null : codigosap,
        "nrodocumento": nrodocumento == null ? null : nrodocumento,
        "apto": apto == null ? null : apto,
        "key": key == null ? null : key,
        "idtemporada": idtemporada == null ? null : idtemporada,
        "fecha": fecha == null ? null : fecha.toIso8601String(),
        "hora": hora == null ? null : hora.toIso8601String(),
        "idpuntoentrega": idpuntoentrega == null ? null : idpuntoentrega,
    };
}

List<PersonalVehiculoEntity> personalVehiculoEntityFromJson(String str) => List<PersonalVehiculoEntity>.from(json.decode(str).map((x) => PersonalVehiculoEntity.fromJson(x)));

String personalVehiculoEntityToJson(List<PersonalVehiculoEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
