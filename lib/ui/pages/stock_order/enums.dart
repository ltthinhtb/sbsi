enum StockFast { waiting, matching }

extension StockFastExt on StockFast {
  String get name {
    switch (this) {
      case StockFast.waiting:
        return "Chờ khớp";
      case StockFast.matching:
        return "Đã khớp";
    }
  }

  String get value {
    switch (this) {
      case StockFast.waiting:
        return ",1,ALL";
      case StockFast.matching:
        return ',2,ALL';
    }
  }
}
