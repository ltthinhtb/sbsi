import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';
import 'package:sbsi/utils/logger.dart';
import 'package:intl/intl.dart';

class StockUtil {
  static Color itemColorWithColor(String color) {
    switch (color) {
      case "green":
        return AppColors.increase;
      case "red":
        return AppColors.decrease;
      default:
        return AppColors.yellow;
    }
  }

  static Color itemColor(StockData data) {
    num change = data.lastPrice! - data.r!;
    if (change > 0) {
      return AppColors.increase;
    } else if (change < 0) {
      return AppColors.decrease;
    } else {
      return AppColors.yellow;
    }
  }

  static String valueSign(StockData data) {
    num change = data.lastPrice! - data.r!;
    if (change > 0) {
      return "+";
    } else if (change < 0) {
      return "-";
    } else {
      return "";
    }
  }

  static String formatVol10(num _number) {
    try {
      var numberators =
          NumberFormat("###,###,###,###,##", 'en_US').format(_number);
      return numberators;
    } catch (e) {
      logger.e(e.toString());
    }
    return '0';
  }

  static String formatVol(num _number) {
    try {
      var numberators =
          NumberFormat("###,###,###,###,###", 'en_US').format(_number);
      return numberators;
    } catch (e) {
      logger.e(e.toString());
    }
    return '0';
  }

  static String formatMoney(num _number) {
    try {
      var numberators =
          NumberFormat("###,###,###,###,###", 'en_US').format(_number);
      return numberators;
    } catch (e) {
      logger.e(e.toString());
    }
    return '0';
  }

  static String formatPrice(num _number) {
    try {
      var numberators =
          NumberFormat("###,###,###,###,###.##", 'en_US').format(_number);
      return numberators;
    } catch (e) {
      return "0";
    }
  }
}
