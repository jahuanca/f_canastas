// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_apto_temporada_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalAptoTemporadaEntityAdapter
    extends TypeAdapter<PersonalAptoTemporadaEntity> {
  @override
  final int typeId = 38;

  @override
  PersonalAptoTemporadaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalAptoTemporadaEntity(
      id: fields[0] as int,
      idtemporada: fields[1] as int,
      idusuario: fields[2] as int,
      codigosap: fields[3] as String,
      idestado: fields[4] as int,
      estadoLocal: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalAptoTemporadaEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idtemporada)
      ..writeByte(2)
      ..write(obj.idusuario)
      ..writeByte(3)
      ..write(obj.codigosap)
      ..writeByte(4)
      ..write(obj.idestado)
      ..writeByte(5)
      ..write(obj.estadoLocal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalAptoTemporadaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
