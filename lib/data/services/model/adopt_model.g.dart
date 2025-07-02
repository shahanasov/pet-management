// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adopt_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdoptParentModelAdapter extends TypeAdapter<AdoptParentModel> {
  @override
  final int typeId = 0;

  @override
  AdoptParentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdoptParentModel(
      name: fields[0] as String,
      age: fields[1] as int,
      gender: fields[2] as String,
      petName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdoptParentModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.petName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdoptParentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
