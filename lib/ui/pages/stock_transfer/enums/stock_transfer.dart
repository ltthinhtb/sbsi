import '../../../../generated/l10n.dart';

enum StockTransfer { transaction, history }

extension StockTransferExt on StockTransfer {
  String get name {
    switch (this) {
      case StockTransfer.transaction:
        return S.current.stock_exchange;
      case StockTransfer.history:
        return S.current.history_transfer_stock;
    }
  }
}
