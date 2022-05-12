import 'package:hive/hive.dart';

part 'user_stock.g.dart';

@HiveType(typeId: 1)
class UserStock {
  @HiveField(1)
  String name;
  @HiveField(2)
  String userID;

  UserStock({required this.name, required this.userID});

  @override
  String toString() {
    return 'UserStock{name: $name, userID: $userID}';
  }
}
