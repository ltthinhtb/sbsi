import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/utils/logger.dart';

class StoreService extends GetxService {
  static const DB = "db";

  // bảng user
  static const USER = 'user';

  // bảng mã chứng khoán
  static const STOCK = 'stock';

  // list constant stockCompany
  RxList<StockCompanyData> listStockCompany = <StockCompanyData>[].obs;

  // bảng danh mục
  static const CATEGORY = 'category';

  // bảng danh mục
  static const STOCK_USER = 'stock_user';

  var userList = <UserStock>[];

  final stockList = <StockCompanyData>[].obs;

  final categoryList = <CategoryStock>[].obs;

  Future<StoreService> init() async {
    Hive.registerAdapter(UserStockAdapter());
    Hive.registerAdapter(CategoryStockAdapter());
    Hive.registerAdapter(StockCompanyDataAdapter());

    await getListUser();
    await getListCategory();
    await getListStock();
    return this;
  }

  // thông tin user đang đăng nhập
  TokenEntity? get currentUser => Get.find<AuthService>().token.value;

  // lưu danh sách mã chứng khoán vào db danh sách cố định
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

  // lấy thông tin các user đã đăng nhập vào điện thoại
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

  // lấy list category ở db
  Future<void> getListCategory() async {
    Box box = await Hive.openBox(DB);
    try {
      box = Hive.box(DB);
      var categoryBox = box.get(CATEGORY);
      if (categoryBox != null) {
        categoryList.value = categoryBox.cast<CategoryStock>();
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // lấy list stock ở db
  Future<void> getListStock() async {
    Box box = await Hive.openBox(DB);
    try {
      box = Hive.box(DB);
      var stockBox = box.get(STOCK_USER);
      if (stockBox != null) {
        stockList.value = stockBox.cast<StockCompanyData>();
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // thông tin user đăng nhập
  Future<void> addUser(UserStock userStock) async {
    int index =
        userList.indexWhere((element) => userStock.userID == element.userID);
    // nếu user chưa tồn tại
    if (index < 0) {
      userList.add(userStock);
      var box = await Hive.openBox(DB);
      await box.put(USER, userList);
    }
  }

  // lấy list category theo user
  List<CategoryStock> get listCategoryUser {
    var listCategoryUser = <CategoryStock>[];
    categoryList.forEach((element) {
      if (element.fromUserID == currentUser!.data!.user) {
        listCategoryUser.add(element);
      }
    });
    return listCategoryUser;
  }

  Future<void> addCategory(CategoryStock categoryStock) async {
    // kiểm tra xem category mới đã tồn tại hay chưa
    int index = listCategoryUser
        .indexWhere((element) => element.title == categoryStock.title);
    // nếu category mới chưa tồn tại
    if (index < 0) {
      // thêm vào db category
      categoryList.add(categoryStock);
      var box = await Hive.openBox(DB);
      await box.put(CATEGORY, categoryList);
    }
  }

  Future<void> deleteCategory(String title) async {
    // tìm category theo title
    var categoryStock =
        listCategoryUser.firstWhere((element) => element.title == title);
    // xóa category khỏi db
    categoryList.remove(categoryStock);
    var box = await Hive.openBox(DB);
    await box.put(CATEGORY, categoryList);
  }

  Future<void> editCategory(String title, String newTitle) async {
    var index =
        listCategoryUser.indexWhere((element) => element.title == title);
    categoryList[index].title = newTitle;
    categoryList[index].label.value = newTitle; // thay đổi giá trị hiển thị
    var box = await Hive.openBox(DB);
    await box.put(CATEGORY, categoryList);
  }

  // lấy list stock theo category
  List<String> listStockFromCategory(String categoryID) {
    var listStockCategory = <String>[];
    stockList.forEach((element) {
      if (element.fromCategoryID == categoryID) {
        listStockCategory.add(element.stockCode!);
      }
    });
    return listStockCategory;
  }

  Future<void> addStock(CategoryStock category, String stock) async {
    // kiểm tra xem stock mới đã tồn tại hay chưa
    int index = listStockFromCategory(category.uuid)
        .indexWhere((element) => element == stock);
    if (index < 0) {
      // nếu stock mới chưa tồn tại
      // reference StockCompany from stockCode
      var stockCpn =
          listStockCompany.firstWhere((element) => element.stockCode == stock);
      stockCpn.fromCategoryID = category.uuid;
      stockList.add(stockCpn);
      var box = await Hive.openBox(DB);
      await box.put(STOCK_USER, stockList);
    }
  }

  Future<void> removeStock(CategoryStock category, String stock) async {
      // nếu stock mới chưa tồn tại
      // reference StockCompany from stockCode
      var stockCpn =
      listStockCompany.firstWhere((element) => element.stockCode == stock);
      stockList.remove(stockCpn);
      var box = await Hive.openBox(DB);
      await box.put(STOCK_USER, stockList);

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
