// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GPSAdapter extends TypeAdapter<GPS> {
  @override
  final int typeId = 0;

  @override
  GPS read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GPS(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GPS obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GPSAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
