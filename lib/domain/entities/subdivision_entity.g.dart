// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subdivision_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubdivisionEntityAdapter extends TypeAdapter<SubdivisionEntity> {
  @override
  final int typeId = 4;

  @override
  SubdivisionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubdivisionEntity(
      idsubdivision: fields[0] as int,
      detallesubdivision: fields[1] as String,
      iddivision: fields[2] as int,
      subdivision: fields[3] as String,
      division: fields[4] as DivisionEntity,
    );
  }

  @override
  void write(BinaryWriter writer, SubdivisionEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idsubdivision)
      ..writeByte(1)
      ..write(obj.detallesubdivision)
      ..writeByte(2)
      ..write(obj.iddivision)
      ..writeByte(3)
      ..write(obj.subdivision)
      ..writeByte(4)
      ..write(obj.division);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubdivisionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
