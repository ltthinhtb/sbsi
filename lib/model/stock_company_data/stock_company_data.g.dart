// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_company_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockCompanyDataAdapter extends TypeAdapter<StockCompanyData> {
  @override
  final int typeId = 3;

  @override
  StockCompanyData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockCompanyData(
      stockCode: fields[1] as String?,
      nameVn: fields[2] as String?,
      nameEn: fields[3] as String?,
      postTo: fields[4] as String?,
      nameShort: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StockCompanyData obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.stockCode)
      ..writeByte(2)
      ..write(obj.nameVn)
      ..writeByte(3)
      ..write(obj.nameEn)
      ..writeByte(4)
      ..write(obj.postTo)
      ..writeByte(5)
      ..write(obj.nameShort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockCompanyDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
