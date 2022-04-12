import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLoading {
  static void showLoading() {
    EasyLoading.show(dismissOnTap: false);
  }

  static void disMissLoading() {
    EasyLoading.dismiss();
  }
}
