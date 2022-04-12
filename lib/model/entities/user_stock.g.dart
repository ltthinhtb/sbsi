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
      category: (fields[3] as List).cast<CategoryStock>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserStock obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userID)
      ..writeByte(3)
      ..write(obj.category);
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
