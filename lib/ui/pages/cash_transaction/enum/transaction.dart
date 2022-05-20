import '../../../../generated/l10n.dart';

enum Transaction { money, stock }

extension TransactionExt on Transaction {
  get name {
    switch (this) {
      case Transaction.money:
        return S.current.transaction_money;
      case Transaction.stock:
        return S.current.transaction_stock;
    }
  }
}
