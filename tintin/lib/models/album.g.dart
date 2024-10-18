// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 1;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(
      title: fields[1] as String,
      numero: fields[0] as int,
      year: fields[2] as int,
      yearInColor: fields[3] as int?,
      image: fields[4] as String,
      resume: fields[5] as String,
      gps: fields[6] as GPS,
      location: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.numero)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.yearInColor)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.resume)
      ..writeByte(6)
      ..write(obj.gps)
      ..writeByte(7)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
