enum TransfersType {
  bank,
  internal,
}

extension TransfersExt on TransfersType {
  get name {
    switch (this) {
      case TransfersType.bank:
        return "Ngân hàng";
      case TransfersType.internal:
        return "Nội bộ";
    }
  }

  String value({String? type}) {
    switch (this) {
      case TransfersType.bank:
        return type!;
      case TransfersType.internal:
        return "INTERNAL";
    }
  }
}
