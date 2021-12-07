// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temporada_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemporadaEntityAdapter extends TypeAdapter<TemporadaEntity> {
  @override
  final int typeId = 36;

  @override
  TemporadaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemporadaEntity(
      id: fields[0] as int,
      idproducto: fields[1] as int,
      anio: fields[2] as String,
      descripcion: fields[3] as String,
      periodo: fields[4] as String,
      estadoLocal: fields[5] as String,
      producto: fields[6] as ProductoEntity,
      personalApto: (fields[7] as List)?.cast<PersonalAptoTemporadaEntity>(),
      sizeVehiculos: fields[9] as int,
      sizePersonalRegistrados: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TemporadaEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idproducto)
      ..writeByte(2)
      ..write(obj.anio)
      ..writeByte(3)
      ..write(obj.descripcion)
      ..writeByte(4)
      ..write(obj.periodo)
      ..writeByte(5)
      ..write(obj.estadoLocal)
      ..writeByte(6)
      ..write(obj.producto)
      ..writeByte(7)
      ..write(obj.personalApto)
      ..writeByte(9)
      ..write(obj.sizeVehiculos)
      ..writeByte(10)
      ..write(obj.sizePersonalRegistrados);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemporadaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
