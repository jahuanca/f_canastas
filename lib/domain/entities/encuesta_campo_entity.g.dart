// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_campo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncuestaCampoEntityAdapter extends TypeAdapter<EncuestaCampoEntity> {
  @override
  final int typeId = 56;

  @override
  EncuestaCampoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncuestaCampoEntity(
      idcampo: fields[0] as int,
      campo: fields[1] as String,
      descripcion: fields[2] as String,
      idetapa: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EncuestaCampoEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idcampo)
      ..writeByte(1)
      ..write(obj.campo)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.idetapa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncuestaCampoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
