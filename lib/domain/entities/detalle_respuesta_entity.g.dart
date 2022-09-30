// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalle_respuesta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetalleRespuestaEntityAdapter
    extends TypeAdapter<DetalleRespuestaEntity> {
  @override
  final int typeId = 52;

  @override
  DetalleRespuestaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetalleRespuestaEntity(
      id: fields[0] as int,
      idusuario: fields[2] as int,
      idopcion: fields[3] as int,
      opcionmanual: fields[11] as String,
      fecha: fields[5] as DateTime,
      hora: fields[6] as DateTime,
      descripcion: fields[7] as String,
      observacion: fields[8] as String,
      estado: fields[9] as String,
      estadoLocal: fields[10] as int,
      idrespuesta: fields[12] as int,
      keyRespuesta: fields[13] as int,
    )..codigoempresa = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, DetalleRespuestaEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.idusuario)
      ..writeByte(3)
      ..write(obj.idopcion)
      ..writeByte(4)
      ..write(obj.codigoempresa)
      ..writeByte(5)
      ..write(obj.fecha)
      ..writeByte(6)
      ..write(obj.hora)
      ..writeByte(7)
      ..write(obj.descripcion)
      ..writeByte(8)
      ..write(obj.observacion)
      ..writeByte(9)
      ..write(obj.estado)
      ..writeByte(10)
      ..write(obj.estadoLocal)
      ..writeByte(11)
      ..write(obj.opcionmanual)
      ..writeByte(12)
      ..write(obj.idrespuesta)
      ..writeByte(13)
      ..write(obj.keyRespuesta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetalleRespuestaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
