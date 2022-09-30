// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_respuestas_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalRespuestasEntityAdapter
    extends TypeAdapter<PersonalRespuestasEntity> {
  @override
  final int typeId = 58;

  @override
  PersonalRespuestasEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalRespuestasEntity(
      id: fields[7] as int,
      key: fields[0] as int,
      codigoempresa: fields[1] as String,
      idencuesta: fields[5] as int,
      personal: fields[6] as PersonalEmpresaEntity,
      respuestas: (fields[2] as List)?.cast<RespuestaEntity>(),
      fecha: fields[3] as DateTime,
      hora: fields[8] as DateTime,
      estadoLocal: fields[4] as int,
      estado: fields[9] as String,
      idunidad: fields[10] as int,
      idetapa: fields[11] as int,
      idcampo: fields[12] as int,
      idturno: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalRespuestasEntity obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.personal)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.hora)
      ..writeByte(9)
      ..write(obj.estado)
      ..writeByte(10)
      ..write(obj.idunidad)
      ..writeByte(11)
      ..write(obj.idetapa)
      ..writeByte(12)
      ..write(obj.idcampo)
      ..writeByte(13)
      ..write(obj.idturno);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalRespuestasEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
