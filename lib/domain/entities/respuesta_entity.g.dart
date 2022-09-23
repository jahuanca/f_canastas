// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuesta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespuestaEntityAdapter extends TypeAdapter<RespuestaEntity> {
  @override
  final int typeId = 52;

  @override
  RespuestaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RespuestaEntity(
      id: fields[0] as int,
      idsubdivision: fields[1] as int,
      idusuario: fields[2] as int,
      idencuesta: fields[3] as int,
      idpregunta: fields[4] as int,
      idopcion: fields[5] as int,
      codigoempresa: fields[6] as String,
      opcionmanual: fields[7] as String,
      fecha: fields[8] as DateTime,
      hora: fields[9] as DateTime,
      descripcion: fields[10] as String,
      observacion: fields[11] as String,
      estado: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RespuestaEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idsubdivision)
      ..writeByte(2)
      ..write(obj.idusuario)
      ..writeByte(3)
      ..write(obj.idencuesta)
      ..writeByte(4)
      ..write(obj.idpregunta)
      ..writeByte(5)
      ..write(obj.idopcion)
      ..writeByte(6)
      ..write(obj.codigoempresa)
      ..writeByte(7)
      ..write(obj.opcionmanual)
      ..writeByte(8)
      ..write(obj.fecha)
      ..writeByte(9)
      ..write(obj.hora)
      ..writeByte(10)
      ..write(obj.descripcion)
      ..writeByte(11)
      ..write(obj.observacion)
      ..writeByte(12)
      ..write(obj.estado);
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
