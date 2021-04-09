// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confessor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfessorAdapter extends TypeAdapter<Confessor> {
  @override
  final int typeId = 0;

  @override
  Confessor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Confessor(
      photo: fields[0] as dynamic,
      name: fields[1] as String,
      notes: fields[2] as String,
      phone: fields[3] as String,
      address: fields[4] as String,
      lastConfessDate: fields[5] as DateTime,
    )..email = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, Confessor obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.lastConfessDate)
      ..writeByte(6)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfessorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
