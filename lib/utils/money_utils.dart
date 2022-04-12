import 'package:intl/intl.dart';

import 'logger.dart';

class MoneyFormat {
  static String formatVol10(String _number) {
    try {
      String num = "0";
      var numerators = NumberFormat("###,###,###,###", 'en_US');
      var number = int.parse(_number);
      String numStr = numerators.format(number * 10);
      num = numStr.substring(0, numStr.length - 1);
      return num;
    } catch (e) {
      logger.e(e.toString());
    }
    return '0';
  }

  static String formatMoneyRound(String _price) {
    var df = NumberFormat(
        "###,###,###,###,###", 'en_US'); // or pattern "###,###.##$"
    String money = "0";
    try {
      if (_price.isNotEmpty) {
        double number = double.parse(_price);
        money = df.format(number);
      } else {
        throw (Exception);
      }
    } catch (e) {
      return "0";
    }
    return money;
  }
}
