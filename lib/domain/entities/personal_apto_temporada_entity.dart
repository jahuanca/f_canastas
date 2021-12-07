// To parse this JSON data, do
//
//     final temporadaEntity = temporadaEntityFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'personal_apto_temporada_entity.g.dart';

@HiveType(typeId: 38)

class PersonalAptoTemporadaEntity {
    PersonalAptoTemporadaEntity({
        this.id,
        this.idtemporada,
        this.idusuario,
        this.codigosap,
        this.idestado,
        this.estadoLocal,
    });

    @HiveField(0)
    int id;
    @HiveField(1)
    int idtemporada;
    @HiveField(2)
    int idusuario;
    @HiveField(3)
    String codigosap;
    @HiveField(4)
    int idestado;
    @HiveField(5)
    String estadoLocal;

    factory PersonalAptoTemporadaEntity.fromJson(Map<String, dynamic> json) => PersonalAptoTemporadaEntity(
        id: json["id"] == null ? null : json["id"],
        idtemporada: json["idtemporada"] == null ? null : json["idtemporada"],
        idusuario: json["idusuario"] == null ? null : json["idusuario"],
        codigosap: json["codigosap"] == null ? null : json["codigosap"],
        idestado: json["idestado"] == null ? null : json["idestado"],
        estadoLocal: json["estadoLocal"] == null ? null : json["estadoLocal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "idtemporada": idtemporada == null ? null : idtemporada,
        "idusuario": idusuario == null ? null : idusuario,
        "codigosap": codigosap == null ? null : codigosap,
        "idestado": idestado == null ? null : idestado,
        "estadoLocal": estadoLocal == null ? null : estadoLocal,
    };
}

List<PersonalAptoTemporadaEntity> personalAptoTemporadaEntityFromJson(String str) => List<PersonalAptoTemporadaEntity>.from(json.decode(str).map((x) => PersonalAptoTemporadaEntity.fromJson(x)));

String personalAptoTemporadaEntityToJson(List<PersonalAptoTemporadaEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));