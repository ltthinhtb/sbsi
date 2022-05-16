enum TransfersType {
  bank,
  internal,
}

extension TransfersExt on TransfersType {
  get name {
    switch (this) {
      case TransfersType.bank:
        return "Chuyển tiền ra ngân hàng";
      case TransfersType.internal:
        return "Chuyển tiền nội bộ";
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
