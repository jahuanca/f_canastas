// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_turno_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncuestaTurnoEntityAdapter extends TypeAdapter<EncuestaTurnoEntity> {
  @override
  final int typeId = 57;

  @override
  EncuestaTurnoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncuestaTurnoEntity(
      idturno: fields[0] as int,
      turno: fields[1] as String,
      descripcion: fields[2] as String,
      idcampo: fields[3] as int,
      idetapa: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EncuestaTurnoEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idturno)
      ..writeByte(1)
      ..write(obj.turno)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.idcampo)
      ..writeByte(4)
      ..write(obj.idetapa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncuestaTurnoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
