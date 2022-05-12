// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryStockAdapter extends TypeAdapter<CategoryStock> {
  @override
  final int typeId = 2;

  @override
  CategoryStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryStock(
      title: fields[1] as String,
      uuid: fields[2] as String,
      fromUserID: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryStock obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.uuid)
      ..writeByte(3)
      ..write(obj.fromUserID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
