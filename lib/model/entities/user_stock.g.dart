// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStockAdapter extends TypeAdapter<UserStock> {
  @override
  final int typeId = 1;

  @override
  UserStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStock(
      name: fields[1] as String,
      userID: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserStock obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
