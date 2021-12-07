// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehiculo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehiculoEntityAdapter extends TypeAdapter<VehiculoEntity> {
  @override
  final int typeId = 35;

  @override
  VehiculoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehiculoEntity(
      id: fields[0] as int,
      placa: fields[1] as String,
      modelo: fields[2] as String,
      fechamod: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, VehiculoEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.placa)
      ..writeByte(2)
      ..write(obj.modelo)
      ..writeByte(3)
      ..write(obj.fechamod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehiculoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
