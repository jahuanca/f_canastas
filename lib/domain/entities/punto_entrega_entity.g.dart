// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_entrega_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuntoEntregaEntityAdapter extends TypeAdapter<PuntoEntregaEntity> {
  @override
  final int typeId = 41;

  @override
  PuntoEntregaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PuntoEntregaEntity(
      id: fields[0] as int,
      nombre: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PuntoEntregaEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuntoEntregaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
