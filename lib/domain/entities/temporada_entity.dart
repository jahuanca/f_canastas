// To parse this JSON data, do
//
//     final temporadaEntity = temporadaEntityFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_actividades/domain/entities/personal_apto_temporada_entity.dart';
import 'package:flutter_actividades/domain/entities/producto_entity.dart';
import 'package:flutter_actividades/domain/entities/vehiculo_temporada_entity.dart';
import 'package:hive/hive.dart';

part 'temporada_entity.g.dart';

@HiveType(typeId: 36)

class TemporadaEntity {
    TemporadaEntity({
        this.id,
        this.idproducto,
        this.anio,
        this.descripcion,
        this.periodo,
        this.estadoLocal,
        this.producto,
        this.personalApto,
        this.vehiculoTemporadas,
        this.sizeVehiculos,
        this.sizePersonalRegistrados,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idproducto;
    @HiveField(2)
    String anio;
    @HiveField(3)
    String descripcion;
    @HiveField(4)
    String periodo;
    @HiveField(5)
    String estadoLocal;
    @HiveField(6)
    ProductoEntity producto;
    @HiveField(7)
    List<PersonalAptoTemporadaEntity> personalApto;
    /* @HiveField(8) */
    List<VehiculoTemporadaEntity> vehiculoTemporadas;
    @HiveField(9)
    int sizeVehiculos;
    @HiveField(10)
    int sizePersonalRegistrados;

    factory TemporadaEntity.fromJson(Map<String, dynamic> json) => TemporadaEntity(
        id: json["id"] == null ? null : json["id"],
        idproducto: json["idproducto"] == null ? null : json["idproducto"],
        anio: json["anio"] == null ? null : json["anio"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        periodo: json["periodo"] == null ? null : json["periodo"],
        sizeVehiculos: json["sizeVehiculos"] == null ? null : json["sizeVehiculos"],
        sizePersonalRegistrados: json["sizePersonalRegistrados"] == null ? null : json["sizePersonalRegistrados"],
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
        producto: json["Producto"] == null ? null : ProductoEntity.fromJson(json["Producto"]),
        personalApto: json["Personal_Apto_Temporadas"] == null ? null : List<PersonalAptoTemporadaEntity>.from(json["Personal_Apto_Temporadas"].map((x) => PersonalAptoTemporadaEntity.fromJson(x))),
        vehiculoTemporadas: json["Vehiculo_Temporadas"] == null ? [] : List<VehiculoTemporadaEntity>.from(json["Vehiculo_Temporadas"].map((x) => VehiculoTemporadaEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idproducto": idproducto == null ? null : idproducto,
        "anio": anio == null ? null : anio,
        "descripcion": descripcion == null ? null : descripcion,
        "sizeVehiculos": sizeVehiculos == null ? null : sizeVehiculos,
        "sizePersonalRegistrados": sizePersonalRegistrados == null ? null : sizePersonalRegistrados,
        "periodo": periodo == null ? null : periodo,
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
        "Producto": producto == null ? null : producto?.toJson(),
        "Personal_Apto_Temporadas": personalApto == null ? null : List<dynamic>.from(personalApto.map((x) => x.toJson())),
        "Vehiculo_Temporadas": vehiculoTemporadas == null ? [] : List<dynamic>.from(vehiculoTemporadas.map((x) => x.toJson())),
    };
}

List<TemporadaEntity> temporadaEntityFromJson(String str) => List<TemporadaEntity>.from(json.decode(str).map((x) => TemporadaEntity.fromJson(x)));

String temporadaEntityToJson(List<TemporadaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));