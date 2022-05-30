import 'package:sbsi/generated/l10n.dart';

enum CashCanAdv { cashCanAdv, history }

extension CashCanAdvExt on CashCanAdv {
  String get name {
    switch (this) {
      case CashCanAdv.cashCanAdv:
        return S.current.advance_money;
      case CashCanAdv.history:
        return S.current.advance_money_history;
    }
  }
}
