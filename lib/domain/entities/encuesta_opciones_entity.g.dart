// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_opciones_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncuestaOpcionesEntityAdapter
    extends TypeAdapter<EncuestaOpcionesEntity> {
  @override
  final int typeId = 43;

  @override
  EncuestaOpcionesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncuestaOpcionesEntity(
      id: fields[0] as int,
      idencuesta: fields[1] as int,
      idusuario: fields[2] as int,
      opcion: fields[3] as String,
      descripcion: fields[4] as String,
      observacion: fields[5] as String,
      estado: fields[6] as String,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EncuestaOpcionesEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idencuesta)
      ..writeByte(2)
      ..write(obj.idusuario)
      ..writeByte(3)
      ..write(obj.opcion)
      ..writeByte(4)
      ..write(obj.descripcion)
      ..writeByte(5)
      ..write(obj.observacion)
      ..writeByte(6)
      ..write(obj.estado)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncuestaOpcionesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
