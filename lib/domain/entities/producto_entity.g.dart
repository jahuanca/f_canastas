// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoEntityAdapter extends TypeAdapter<ProductoEntity> {
  @override
  final int typeId = 37;

  @override
  ProductoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductoEntity(
      id: fields[0] as int,
      descripcion: fields[1] as String,
      unidad: fields[2] as String,
      fechamod: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductoEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.unidad)
      ..writeByte(3)
      ..write(obj.fechamod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
