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
      photo: fields[0] as Uint8List?,
      fName: fields[1] as String,
      lName: fields[2] as String,
      notes: (fields[3] as List).cast<Note>(),
      phone: fields[4] as String,
      countryCode: fields[5] as String,
      address: fields[6] as String?,
      lastConfessDate: fields[7] as DateTime,
      email: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Confessor obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.fName)
      ..writeByte(2)
      ..write(obj.lName)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.countryCode)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.lastConfessDate)
      ..writeByte(8)
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
