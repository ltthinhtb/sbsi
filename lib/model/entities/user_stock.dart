import 'package:hive/hive.dart';
import 'package:sbsi/model/entities/category_stock.dart';

part 'user_stock.g.dart';

@HiveType(typeId: 1)
class UserStock {
  @HiveField(1)
  String name;
  @HiveField(2)
  String userID;
  @HiveField(3)
  List<CategoryStock> category;

  UserStock({required this.name, required this.userID, required this.category});

  @override
  String toString() {
    return 'UserStock{name: $name, userID: $userID, category: $category}';
  }
}
