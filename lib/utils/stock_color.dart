enum StockPrice { increase, decrease, f, c, r }

extension StockExt on StockPrice {
  String get color {
    switch (this) {
      case StockPrice.increase:
        return 'green'; // tăng
      case StockPrice.decrease:
        return "red"; // giẳm
      case StockPrice.f:
        return "blue"; // sàn
      case StockPrice.c:
        return "violet"; // trần
      case StockPrice.r:
        return "yellow"; // tham chiếu
      default:
        return "yellow";
    }

  }
}