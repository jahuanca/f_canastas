// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncuestaEntityAdapter extends TypeAdapter<EncuestaEntity> {
  @override
  final int typeId = 42;

  @override
  EncuestaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncuestaEntity(
      id: fields[0] as int,
      idusuario: fields[1] as int,
      idtipoencuesta: fields[2] as int,
      periodo: fields[3] as String,
      fechaInicio: fields[4] as DateTime,
      fechaFin: fields[5] as DateTime,
      titulo: fields[6] as String,
      descripcion: fields[7] as String,
      observacion: fields[8] as String,
      estado: fields[10] as String,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      key: fields[13] as int,
      firmasupervisor: fields[14] as String,
      cantidadTotal: fields[15] as int,
      cantidadEnviados: fields[16] as int,
      anio: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EncuestaEntity obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idusuario)
      ..writeByte(2)
      ..write(obj.idtipoencuesta)
      ..writeByte(3)
      ..write(obj.periodo)
      ..writeByte(4)
      ..write(obj.fechaInicio)
      ..writeByte(5)
      ..write(obj.fechaFin)
      ..writeByte(6)
      ..write(obj.titulo)
      ..writeByte(7)
      ..write(obj.descripcion)
      ..writeByte(8)
      ..write(obj.observacion)
      ..writeByte(10)
      ..write(obj.estado)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.key)
      ..writeByte(14)
      ..write(obj.firmasupervisor)
      ..writeByte(15)
      ..write(obj.cantidadTotal)
      ..writeByte(16)
      ..write(obj.cantidadEnviados)
      ..writeByte(17)
      ..write(obj.anio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncuestaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
