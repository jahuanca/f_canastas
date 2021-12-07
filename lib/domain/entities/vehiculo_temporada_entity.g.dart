// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehiculo_temporada_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehiculoTemporadaEntityAdapter
    extends TypeAdapter<VehiculoTemporadaEntity> {
  @override
  final int typeId = 39;

  @override
  VehiculoTemporadaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehiculoTemporadaEntity(
      id: fields[0] as int,
      placa: fields[3] as String,
      idtemporada: fields[1] as int,
      idusuario: fields[6] as int,
      idvehiculo: fields[2] as int,
      fecha: fields[4] as DateTime,
      hora: fields[5] as DateTime,
      key: fields[8] as int,
      estadoLocal: fields[9] as String,
      pathUrl: fields[10] as String,
      firmasupervisor: fields[11] as String,
      sizeDetails: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VehiculoTemporadaEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idtemporada)
      ..writeByte(2)
      ..write(obj.idvehiculo)
      ..writeByte(3)
      ..write(obj.placa)
      ..writeByte(4)
      ..write(obj.fecha)
      ..writeByte(5)
      ..write(obj.hora)
      ..writeByte(6)
      ..write(obj.idusuario)
      ..writeByte(8)
      ..write(obj.key)
      ..writeByte(9)
      ..write(obj.estadoLocal)
      ..writeByte(10)
      ..write(obj.pathUrl)
      ..writeByte(11)
      ..write(obj.firmasupervisor)
      ..writeByte(12)
      ..write(obj.sizeDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehiculoTemporadaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
