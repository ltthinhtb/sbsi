import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sbsi/model/entities/category_stock.dart';
import 'package:sbsi/model/entities/user_stock.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/utils/logger.dart';

class StoreService extends GetxService {
  static const DB = "db";
  static const USER = 'user';
  static const STOCK = 'stock';

  var userList = <UserStock>[];

  late UserStock currentUser;

  late RxList<CategoryStock> currentCategory;

  RxList<StockCompanyData> listStockCompany = <StockCompanyData>[].obs;

  Future<StoreService> init() async {
    Hive.registerAdapter(UserStockAdapter());
    Hive.registerAdapter(CategoryStockAdapter());
    Hive.registerAdapter(StockCompanyDataAdapter());

    await getListUser();
    return this;
  }


  Future<void> saveListStockCompany(List<StockCompanyData> listData) async {
    try {
      Box box = await Hive.openBox(DB);
      box = Hive.box(DB);
      await box.put(STOCK, listData);
      listStockCompany.value = listData;
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> getListUser() async {
    Box box = await Hive.openBox(DB);
    try {
      box = Hive.box(DB);
      var userBox = box.get(USER);
      if (userBox != null) {
        userList = userBox.cast<UserStock>();
      }
      print('==========> Số user đã đăng nhập ${userList.length}');
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> addUser(UserStock userStock) async {
    int index =
        userList.indexWhere((element) => userStock.userID == element.userID);
    if (index < 0) {
      userList.add(userStock);
      var box = await Hive.openBox(DB);
      await box.put(USER, userList);
      currentUser = userStock;
      currentCategory = <CategoryStock>[].obs;
    } else {
      currentUser = userList[index];
      currentCategory = currentUser.category.obs;
    }
    print(
        '==========> Số category hiện tại của tài khoản ${currentCategory.length}');
  }

  Future<void> addCategory(CategoryStock categoryStock) async {
    int index = currentCategory
        .indexWhere((element) => element.title == categoryStock.title);
    if (index < 0) {
      currentCategory.add(categoryStock);
      currentUser.category = currentCategory.toList();
      var indexUser = userList
          .indexWhere((element) => element.userID == currentUser.userID);
      userList[indexUser] = currentUser;
      var box = await Hive.openBox(DB);
      await box.put(USER, userList);
    }
  }

  Future<void> deleteCategory(String title) async {
    var categoryStock =
        currentCategory.firstWhere((element) => element.title == title);
    currentCategory.remove(categoryStock);
    currentUser.category = currentCategory.toList();
    userList[userList.indexOf(currentUser)] = currentUser;
    var box = await Hive.openBox(DB);
    await box.put(USER, userList);
  }

  Future<void> editCategory(String title, String newTitle) async {
    var index = currentCategory.indexWhere((element) => element.title == title);
    currentCategory[index].title = newTitle;
    currentCategory[index].label.value = newTitle; // thay đổi giá trị hiển thị
    currentUser.category = currentCategory.toList();
    userList[userList.indexOf(currentUser)] = currentUser;
    var box = await Hive.openBox(DB);
    await box.put(USER, userList);
  }

  Future<void> addStock(String category, String stock) async {
    int index =
        currentCategory.indexWhere((element) => element.title == category);
    if (index >= 0) {
      /// kiểm tra xem mã đã tồn tại chưa
      if (!currentCategory[index].stocks.contains(stock)) {
        currentCategory[index].stocks.add(stock);
      }
      logger.e(currentCategory[index].stocks.length);
      currentUser.category = currentCategory.toList();
      var indexUser = userList
          .indexWhere((element) => element.userID == currentUser.userID);
      userList[indexUser] = currentUser;
      var box = await Hive.openBox(DB);
      await box.put(USER, userList);
    }
  }

  void clearDisk() {
    try {
      Hive.deleteBoxFromDisk(DB);
    } catch (error) {
      logger.e(error.toString());
    }
    userList = [];
  }
}
