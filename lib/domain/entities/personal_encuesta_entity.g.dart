// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_encuesta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalEncuestaEntityAdapter
    extends TypeAdapter<PersonalEncuestaEntity> {
  @override
  final int typeId = 53;

  @override
  PersonalEncuestaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalEncuestaEntity(
      key: fields[0] as int,
      codigoempresa: fields[1] as String,
      respuestas: (fields[2] as List)?.cast<RespuestaEntity>(),
      estadoLocal: fields[4] as int,
      fecha: fields[3] as DateTime,
      idencuesta: fields[5] as int,
      personal: fields[6] as PersonalEmpresaEntity,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalEncuestaEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.codigoempresa)
      ..writeByte(2)
      ..write(obj.respuestas)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.estadoLocal)
      ..writeByte(5)
      ..write(obj.idencuesta)
      ..writeByte(6)
      ..write(obj.personal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalEncuestaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
