import 'dart:convert';

// ignore: unused_import
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';

import '../model/stock_data/cash_balance.dart';
import 'logger.dart';

class OrderUtils {
  static String getRandom() {
    String text = "";
    String possible =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = Random();
    for (int i = 0; i < 23; i++) {
      text += possible[(random.nextDouble() * possible.length).toInt()];
    }
    return text;
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static bool checkPrice(StockInfo stock, {required String price}) {
    var _c = ((stock.c ?? 0) * 1000).round();
    var _f = ((stock.f ?? 0) * 1000).round();
    try {
      print(_c);
      print(_f);
      var vPrice = double.parse(price);
      if ((vPrice * 1000).round() > _c) {
        AppSnackBar.showError(message: "Giá không được quá giá trần $_c");
        return false;
      }
      if ((vPrice * 1000).round() < _f) {
        AppSnackBar.showError(message: "Giá không được nhỏ hơn giá sàn $_f");
        return false;
      }
      if (stock.mc == "HA") {
        return validPriceHnx(price);
      }
      if (stock.mc == "HO") {
        return validPriceHose(price);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool validPriceHose(String value) {
    var step = 10;
    try {
      var price = double.parse(value).toInt();
      if (price < 10)
        step = 10;
      else if (price >= 10 && price < 50) {
        step = 50;
      } else
        step = 100;
      var data = ((price * 1000 * 10) % (step * 10)).round();
      if (data % 10 != 0) {
        AppSnackBar.showError(message: "Gía không hợp lệ");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool validPriceHnx(String value) {
    var step = 100;
    try {
      var price = double.parse(value).toInt();
      var data = ((price * 1000 * 10) % (step * 10)).round();
      if (data % 10 != 0) {
        AppSnackBar.showError(message: "Gía không hợp lệ");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static num parseNumber(String value) {
    try {
      return num.parse(value);
    } catch (e) {
      return 0;
    }
  }

  static bool checkVol(StockInfo stock,
      {required num vol,
      required CashBalance cashBalance,
      required bool isBuy}) {
    try {
      num volume = vol;

      num maxVolBuy = parseNumber('${cashBalance.volumeAvaiable}');
      num maxVolSell = parseNumber('${cashBalance.balance}');
      bool validate = true;
      bool validateVol = true;
      if (stock.mc == "HO") {
        validate = validVolHouse(volume.toString());
      }
      if (stock.mc == "HA") {
        validate = validVolHnx(volume.toString());
      }
      if(volume < 100 && validate && stock.mc == "HO"){
        if(stock.mc!= "LO"){
          AppSnackBar.showError(
              message: "Lệnh lô lẻ chỉ đặt giá LO");
          return false;
        }
      }
      if (isBuy) {
        if (volume > maxVolBuy) {
          AppSnackBar.showError(
              message: "Khối lượng mua vượt khối lượng tối đa");
          validateVol = false;
        }
      }
      if(!isBuy){
        if (volume > maxVolSell) {
          AppSnackBar.showError(
              message: "Khối lượng bán vượt khối lượng tối đa");
          validateVol = false;
        }
      }
      return validate && validateVol;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  static bool validVolHouse(String vol) {
    var step = 100;
    try {
      var volume = double.parse(vol).toInt();
      if (volume < 1 || volume > 500000) {
        AppSnackBar.showError(message: "Khối lượng không hợp lệ");
        return false;
      }
      if (volume % step != 0) {
        AppSnackBar.showError(message: "Khối lượng không hợp lệ");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool validVolHnx(String vol) {
    var step = 100;
    try {
      var volume = double.parse(vol).toInt();
      if (volume == 0) {
        AppSnackBar.showError(message: "Khối lượng không hợp lệ");
        return false;
      }
      if (volume >= 100 && volume % step != 0) {
        AppSnackBar.showError(message: "Khối lượng không hợp lệ");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

enum PricesType { MP, ATC, ATO, MTL, MOK, MAK, PLO }

class PriceType {
  static String get LO => "LO";

  static String get MP => "MP";

  static String get ATC => "ATC";

  static String get ATO => "ATO";

  static String get MTL => "MTL";

  static String get MOK => "MOK";

  static String get MAK => "MAK";

  static String get PLO => "PLO";
}
