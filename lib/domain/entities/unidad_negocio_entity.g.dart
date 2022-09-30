// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unidad_negocio_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnidadNegocioEntityAdapter extends TypeAdapter<UnidadNegocioEntity> {
  @override
  final int typeId = 54;

  @override
  UnidadNegocioEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UnidadNegocioEntity(
      idunidad: fields[0] as int,
      descripcion: fields[1] as String,
      grupo: fields[2] as String,
      sociedad: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UnidadNegocioEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idunidad)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.grupo)
      ..writeByte(3)
      ..write(obj.sociedad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnidadNegocioEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
