import 'package:hive_flutter/hive_flutter.dart';
part 'stock_company_data.g.dart';

@HiveType(typeId: 3)
class StockCompanyData {
  @HiveField(1)
  String? stockCode;
  @HiveField(2)
  String? nameVn;
  @HiveField(3)
  String? nameEn;
  @HiveField(4)
  String? postTo;
  @HiveField(5)
  String? nameShort;

  StockCompanyData(
      {this.stockCode, this.nameVn, this.nameEn, this.postTo, this.nameShort});

  StockCompanyData.fromJson(Map<String, dynamic> json) {
    stockCode = json['stock_code'];
    nameVn = json['name_vn'];
    nameEn = json['name_en'];
    postTo = json['post_to'];
    nameShort = json['name_short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stock_code'] = stockCode;
    data['name_vn'] = nameVn;
    data['name_en'] = nameEn;
    data['post_to'] = postTo;
    data['name_short'] = nameShort;
    return data;
  }
}
