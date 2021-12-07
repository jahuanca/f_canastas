// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_vehiculo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalVehiculoEntityAdapter
    extends TypeAdapter<PersonalVehiculoEntity> {
  @override
  final int typeId = 40;

  @override
  PersonalVehiculoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalVehiculoEntity(
      id: fields[0] as int,
      idvehiculotemporada: fields[1] as int,
      idusuario: fields[2] as int,
      codigosap: fields[3] as String,
      fecha: fields[4] as DateTime,
      hora: fields[5] as DateTime,
      apto: fields[6] as bool,
      personal: fields[7] as PersonalEmpresaEntity,
      idpuntoentrega: fields[8] as int,
      key: fields[9] as int,
      nrodocumento: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalVehiculoEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idvehiculotemporada)
      ..writeByte(2)
      ..write(obj.idusuario)
      ..writeByte(3)
      ..write(obj.codigosap)
      ..writeByte(4)
      ..write(obj.fecha)
      ..writeByte(5)
      ..write(obj.hora)
      ..writeByte(6)
      ..write(obj.apto)
      ..writeByte(7)
      ..write(obj.personal)
      ..writeByte(8)
      ..write(obj.idpuntoentrega)
      ..writeByte(9)
      ..write(obj.key)
      ..writeByte(10)
      ..write(obj.nrodocumento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalVehiculoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
