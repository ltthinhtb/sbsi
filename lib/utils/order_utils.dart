import 'dart:convert';
// ignore: unused_import
import 'dart:math';
import 'package:crypto/crypto.dart';

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

// class OrderStatus {
//   static String get wating_matched => "LO";
//   static String get MP => "MP";
//   static String get ATC => "ATC";
//   static String get ATO => "ATO";
//   static String get MTL => "MTL";
//   static String get MOK => "MOK";
//   static String get MAK => "MAK";
//   static String get PLO => "PLO";
// }
