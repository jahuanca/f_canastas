// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_detalle_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncuestaDetalleEntityAdapter extends TypeAdapter<EncuestaDetalleEntity> {
  @override
  final int typeId = 44;

  @override
  EncuestaDetalleEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncuestaDetalleEntity(
      id: fields[0] as int,
      idencuesta: fields[1] as int,
      idusuario: fields[2] as int,
      descripcion: fields[4] as String,
      observacion: fields[5] as String,
      estado: fields[6] as String,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
      codigoempresa: fields[3] as String,
      fecha: fields[10] as DateTime,
      hora: fields[11] as DateTime,
      idopcionencuesta: fields[13] as int,
      idsubdivision: fields[12] as int,
      opcionmanual: fields[9] as String,
      personal: fields[14] as PersonalEmpresaEntity,
      opcionEncuesta: fields[15] as EncuestaOpcionesEntity,
      key: fields[16] as int,
      estadoLocal: fields[17] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EncuestaDetalleEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idencuesta)
      ..writeByte(2)
      ..write(obj.idusuario)
      ..writeByte(3)
      ..write(obj.codigoempresa)
      ..writeByte(4)
      ..write(obj.descripcion)
      ..writeByte(5)
      ..write(obj.observacion)
      ..writeByte(6)
      ..write(obj.estado)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.opcionmanual)
      ..writeByte(10)
      ..write(obj.fecha)
      ..writeByte(11)
      ..write(obj.hora)
      ..writeByte(12)
      ..write(obj.idsubdivision)
      ..writeByte(13)
      ..write(obj.idopcionencuesta)
      ..writeByte(14)
      ..write(obj.personal)
      ..writeByte(15)
      ..write(obj.opcionEncuesta)
      ..writeByte(16)
      ..write(obj.key)
      ..writeByte(17)
      ..write(obj.estadoLocal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncuestaDetalleEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
