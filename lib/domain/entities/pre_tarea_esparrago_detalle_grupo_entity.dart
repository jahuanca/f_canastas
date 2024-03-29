import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:hive/hive.dart';

part 'pre_tarea_esparrago_detalle_grupo_entity.g.dart';

@HiveType(typeId: 24)
class PreTareaEsparragoDetalleGrupoEntity {
  PreTareaEsparragoDetalleGrupoEntity({
    this.itempretareaesparragodetallegrupo,
    this.itempretareaesparragogrupo,
    this.codigoempresa,
    this.fecha,
    this.hora,
    this.idestado,
    this.personal,
    this.codigotk,
    this.idusuario,
    this.imei,
  });

  @HiveField(0)
  int itempretareaesparragodetallegrupo;
  @HiveField(1)
  int itempretareaesparragogrupo;
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

  bool get validadoParaAprobar{
    if(codigoempresa==null || hora==null){
      return false;
    }
    
    return true;
  }

  factory PreTareaEsparragoDetalleGrupoEntity.fromJson(Map<String, dynamic> json) =>
      PreTareaEsparragoDetalleGrupoEntity(
        itempretareaesparragodetallegrupo: json['itempretareaesparragodetallegrupo'],
        itempretareaesparragogrupo: json['itempretareaesparragogrupo'],
        codigoempresa: json['codigoempresa'],
        hora: DateTime?.parse(json['hora']),
        imei: json['imei'],
        idusuario: json['idusuario'],
        fecha: DateTime?.parse(json['fecha']),
        idestado: json['idestado'],
        codigotk: json['codigotk'],

      );

  Map<String, dynamic> toJson() => {
        'itempretareaesparragodetallegrupo': itempretareaesparragodetallegrupo,
        'itempretareaesparragogrupo': itempretareaesparragogrupo,
        'codigoempresa': codigoempresa,
        'hora': hora?.toIso8601String(),
        'imei': imei,
        'idusuario': idusuario,
        'fecha': fecha?.toIso8601String(),
        
        'idestado': idestado,
        'codigotk': codigotk,
      };
}
