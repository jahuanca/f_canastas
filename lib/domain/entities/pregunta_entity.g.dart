// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregunta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreguntaEntityAdapter extends TypeAdapter<PreguntaEntity> {
  @override
  final int typeId = 50;

  @override
  PreguntaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreguntaEntity(
      id: fields[0] as int,
      idusuario: fields[1] as int,
      idencuesta: fields[2] as int,
      idtipopregunta: fields[3] as int,
      pregunta: fields[4] as String,
      descripcion: fields[5] as String,
      observacion: fields[6] as String,
      estado: fields[7] as String,
      permitirOpcionManual: fields[8] as bool,
      createdAt: fields[9] as DateTime,
      updatedAt: fields[10] as DateTime,
      opciones: (fields[11] as List)?.cast<OpcionEntity>(),
      indexesSelected: (fields[12] as List)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PreguntaEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idusuario)
      ..writeByte(2)
      ..write(obj.idencuesta)
      ..writeByte(3)
      ..write(obj.idtipopregunta)
      ..writeByte(4)
      ..write(obj.pregunta)
      ..writeByte(5)
      ..write(obj.descripcion)
      ..writeByte(6)
      ..write(obj.observacion)
      ..writeByte(7)
      ..write(obj.estado)
      ..writeByte(8)
      ..write(obj.permitirOpcionManual)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.opciones)
      ..writeByte(12)
      ..write(obj.indexesSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreguntaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
