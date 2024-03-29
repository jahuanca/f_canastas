import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/entities/actividad_entity.dart';
import 'package:flutter_actividades/domain/entities/labor_entity.dart';
import 'package:hive/hive.dart';

part 'pre_tarea_esparrago_detalle_varios_entity.g.dart';

@HiveType(typeId: 22)
class PreTareaEsparragoDetalleVariosEntity {
  PreTareaEsparragoDetalleVariosEntity({
    this.itempretareaesparragodetallevarios,
    this.itempretareaesparragovarios,
    this.codigoempresa,
    this.fecha,
    this.hora,
    this.idestado,
    this.personal,
    this.codigotk,
    this.correlativo,
    this.idusuario,
    this.idlabor,
    this.labor,
    this.idactividad,
    this.actividad,
    this.imei,
  });

  @HiveField(0)
  int itempretareaesparragodetallevarios;
  @HiveField(1)
  int itempretareaesparragovarios;
  @HiveField(2)
  int correlativo;
  @HiveField(3)
  String codigoempresa;
  @HiveField(4)
  DateTime hora;
  @HiveField(5)
  String imei;
  @HiveField(6)
  DateTime fecha;
  @HiveField(7)
  int idestado;
  @HiveField(8)
  int idusuario;
  @HiveField(9)
  PersonalEmpresaEntity personal;
  @HiveField(10)
  String codigotk;
  @HiveField(11)
  int idlabor;
  @HiveField(12)
  int idactividad;
  @HiveField(14)
  ActividadEntity actividad;
  @HiveField(15)
  LaborEntity labor;

  bool get validadoParaAprobar{
    if(codigoempresa==null || hora==null){
      return false;
    }
    
    return true;
  }

  factory PreTareaEsparragoDetalleVariosEntity.fromJson(Map<String, dynamic> json) =>
      PreTareaEsparragoDetalleVariosEntity(
        itempretareaesparragodetallevarios: json['itempretareaesparragodetallevarios'],
        itempretareaesparragovarios: json['itempretareaproceso'],
        codigoempresa: json['codigoempresa'],
        idactividad: json['idactividad'],
        hora: DateTime?.parse(json['hora']),
        imei: json['imei'],
        idusuario: json['idusuario'],
        correlativo: json['correlativo'],
        fecha: DateTime?.parse(json['fecha']),
        idlabor: json['idlabor'],
        idestado: json['idestado'],
        codigotk: json['codigotk'],

      );

  Map<String, dynamic> toJson() => {
        'itempretareaesparragodetallevarios': itempretareaesparragodetallevarios,
        'itempretareaesparragovarios': itempretareaesparragovarios,
        'codigoempresa': codigoempresa,
        'idactividad': idactividad,
        'hora': hora?.toIso8601String(),
        'imei': imei,
        'idusuario': idusuario,
        'correlativo': correlativo,
        'fecha': fecha?.toIso8601String(),
        
        'idlabor': idlabor,
        'idestado': idestado,
        'codigotk': codigotk,
      };
}
