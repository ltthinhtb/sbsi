import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive/hive.dart';

part 'category_stock.g.dart';

@HiveType(typeId: 2)
class CategoryStock {
  @HiveField(1)
  /// giá trị value
  String title;
  @HiveField(2)
  List<String> stocks;

  /// giá trị hiển thị
  final label = "".obs;

  CategoryStock({required this.title, required this.stocks}) {
    label.value = title;
  }
}
