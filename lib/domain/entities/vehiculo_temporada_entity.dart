// To parse this JSON data, do
//
//     final vehiculoEntity = vehiculoEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_canastas/domain/entities/personal_vehiculo_entity.dart';
import 'package:hive/hive.dart';

part 'vehiculo_temporada_entity.g.dart';

@HiveType(typeId: 39)

class VehiculoTemporadaEntity {
    VehiculoTemporadaEntity({
        this.id,
        this.placa,
        this.idtemporada,
        this.idusuario,
        this.idvehiculo,
        this.fecha,
        this.hora,
        this.personal,
        this.key,
        this.estadoLocal,
        this.pathUrl,
        this.firmasupervisor,
        this.sizeDetails,
    }){
      estadoLocal ??='P';
    }

    @HiveField(0)
    int id;
    @HiveField(1)
    int idtemporada;
    @HiveField(2)
    int idvehiculo;
    @HiveField(3)
    String placa;
    @HiveField(4)
    DateTime fecha;
    @HiveField(5)
    DateTime hora;
    @HiveField(6)
    int idusuario;
    /* @HiveField(7) */
    List<PersonalVehiculoEntity> personal;
    @HiveField(8)
    int key;
    @HiveField(9)
    String estadoLocal;
    @HiveField(10)
    String pathUrl;
    @HiveField(11)
    String firmasupervisor;
    @HiveField(12)
    int sizeDetails;

    factory VehiculoTemporadaEntity.fromJson(Map<String, dynamic> json) => VehiculoTemporadaEntity(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        sizeDetails: json["sizeDetails"] == null ? null : json["sizeDetails"],
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        idtemporada: json["idtemporada"] == null ? null : json["idtemporada"],
        idvehiculo: json["idvehiculo"] == null ? null : json["idvehiculo"],
        firmasupervisor: json["firmasupervisor"] == null ? null : json["firmasupervisor"],
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
        pathUrl: json["pathUrl"] == null ? null : json["pathUrl"],
        placa: json["placa"] == null ? null : json["placa"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        hora: json["hora"] == null ? null : DateTime.parse(json["hora"]),
        personal: json["Personal_Vehiculos"] == [] ? null : List<PersonalVehiculoEntity>.from(json["Personal_Vehiculos"].map((x) => PersonalVehiculoEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "id": id == null ? null : id,
        "sizeDetails": sizeDetails == null ? null : sizeDetails,
        "idusuario": idusuario == null ? null : idusuario,
        "idvehiculo": idvehiculo == null ? null : idvehiculo,
        "firmasupervisor": firmasupervisor == null ? null : firmasupervisor,
        "estadoLocal": estadoLocal == null ? 'P' : estadoLocal,
        "pathUrl": pathUrl == null ? null : pathUrl,
        "idtemporada": idtemporada == null ? null : idtemporada,
        "placa": placa == null ? null : placa,
        "fecha": fecha == null ? null : fecha.toIso8601String(),
        "hora": hora == null ? null : hora.toIso8601String(),
        "Personal_Vehiculos": personal == [] ? null : List<dynamic>.from(personal.map((x) => x.toJson())),
    };
}

List<VehiculoTemporadaEntity> vehiculoTemporadaEntityFromJson(String str) => List<VehiculoTemporadaEntity>.from(json.decode(str).map((x) => VehiculoTemporadaEntity.fromJson(x)));

String vehiculoTemporadaEntityToJson(List<VehiculoTemporadaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
