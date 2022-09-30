// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_etapa_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncuestaEtapaEntityAdapter extends TypeAdapter<EncuestaEtapaEntity> {
  @override
  final int typeId = 55;

  @override
  EncuestaEtapaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncuestaEtapaEntity(
      idetapa: fields[0] as int,
      etapa: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EncuestaEtapaEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idetapa)
      ..writeByte(1)
      ..write(obj.etapa)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncuestaEtapaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
