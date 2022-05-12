import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sbsi/services/auth_service.dart';

part 'category_stock.g.dart';

@HiveType(typeId: 2)
class CategoryStock {
  @HiveField(1)

  /// giá trị value
  String title;

  @HiveField(2)
  //  key
  String uuid;

  @HiveField(3)
  //  key với userID
  String? fromUserID;

  /// giá trị hiển thị
  final label = "".obs;

  CategoryStock(
      {required this.title, required this.uuid, this.fromUserID}) {
    label.value = title;
   // tạo key với userID
    fromUserID = Get.find<AuthService>().token.value?.data?.user;
  }
}
