// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingModelAdapter extends TypeAdapter<SettingModel> {
  @override
  final int typeId = 4;

  @override
  SettingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingModel(
      darkMOde: fields[0] as bool,
      loctionTracking: fields[1] as String,
      key: (fields[2] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, SettingModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.darkMOde)
      ..writeByte(1)
      ..write(obj.loctionTracking)
      ..writeByte(2)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
