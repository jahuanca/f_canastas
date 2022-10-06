// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuesta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespuestaEntityAdapter extends TypeAdapter<RespuestaEntity> {
  @override
  final int typeId = 53;

  @override
  RespuestaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RespuestaEntity(
      id: fields[11] as int,
      key: fields[0] as int,
      codigoempresa: fields[1] as String,
      detalles: (fields[2] as List)?.cast<DetalleRespuestaEntity>(),
      fecha: fields[3] as DateTime,
      hora: fields[12] as DateTime,
      idencuesta: fields[5] as int,
      personal: fields[6] as PersonalEmpresaEntity,
      idunidad: fields[7] as int,
      idetapa: fields[8] as int,
      idcampo: fields[9] as int,
      idturno: fields[10] as int,
      idpregunta: fields[13] as int,
      estadoLocal: fields[4] as int,
      idusuario: fields[14] as int,
      idsubdivision: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RespuestaEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.codigoempresa)
      ..writeByte(2)
      ..write(obj.detalles)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.estadoLocal)
      ..writeByte(5)
      ..write(obj.idencuesta)
      ..writeByte(6)
      ..write(obj.personal)
      ..writeByte(7)
      ..write(obj.idunidad)
      ..writeByte(8)
      ..write(obj.idetapa)
      ..writeByte(9)
      ..write(obj.idcampo)
      ..writeByte(10)
      ..write(obj.idturno)
      ..writeByte(11)
      ..write(obj.id)
      ..writeByte(12)
      ..write(obj.hora)
      ..writeByte(13)
      ..write(obj.idpregunta)
      ..writeByte(14)
      ..write(obj.idusuario)
      ..writeByte(15)
      ..write(obj.idsubdivision);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespuestaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
