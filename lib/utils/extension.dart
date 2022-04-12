import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/utils/error_message.dart';
import 'package:sbsi/utils/order_utils.dart';

extension StringX on String {
  bool isIn(List<String> list) {
    if (list.contains(this)) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotIn(List<String> list) {
    if (list.contains(this)) {
      return false;
    } else {
      return true;
    }
  }

  bool get isANumber {
    return RegExp(r'^[+-]?(\d+(\,\d+)*(\.\d+)?)$').hasMatch(this);
  }

  bool get isNotANumber {
    return !RegExp(r'^[+-]?(\d+(\,\d+)*(\.\d+)?)$').hasMatch(this);
  }

  bool get isAnInteger {
    return RegExp(r'^[+-]?(\d+(\,\d+)*(.[0]+)?)$').hasMatch(this);
  }

  bool get isNotAnInteger {
    return !RegExp(r'^[+-]?(\d+(\,\d+)*(.[0]+)?)$').hasMatch(this);
  }

  bool get isPositive {
    return RegExp(r'^[+]?(\d+(\,\d+)*(\.\d+)?)$').hasMatch(this);
  }

  bool get isNotPositive {
    return RegExp(r'^((-(\d+(\,\d+)*(\.\d+)?))|0+)$').hasMatch(this);
  }

  bool get isMultipleOfTen {
    return RegExp(r'^[^-](\d+0(\.?0*|\.0+)?)$').hasMatch(this);
  }

  bool get isMultipleOfHundred {
    return RegExp(r'^([1-9]+\d*(\,\d{3})*(\,\d{1})00(\.0+)?)$').hasMatch(this);
  }

  bool get isATO {
    if (this == "ATO") {
      return true;
    } else {
      return false;
    }
  }

  bool get isATC {
    if (this == "ATC") {
      return true;
    } else {
      return false;
    }
  }

  bool get isMP {
    if (this == "MP") {
      return true;
    } else {
      return false;
    }
  }

  bool get isPriceType {
    String? priceType = _priceType[this];
    if (priceType != null) {
      return true;
    } else {
      return false;
    }
  }
}

Map<PricesType, String> get _priceType => {
      PricesType.MP: "MP",
      PricesType.ATO: "ATO",
      PricesType.ATC: "ATC",
      PricesType.MTL: "MTL",
      PricesType.MOK: "MOK",
      PricesType.MAK: "MAK",
      PricesType.PLO: "PLO",
    };

extension IndatOrderX on IndayOrder {
  bool get canFix {
    String _status = MessageOrder.getStatusOrder(this);
    if (_status == "Khớp 1 phần" || _status == "Chờ khớp") {
      return true;
    } else {
      return false;
    }
  }
}

extension NumberX on double {
  bool isInSpace(num below, num above) {
    if (this < below) {
      return false;
    } else if (this > above) {
      return false;
    } else {
      return true;
    }
  }
}
