import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';

enum SingingCharacter { all, waiting, matched, cancel }

extension SingingExt on SingingCharacter {
  String name(BuildContext context) => _mapName(context)[this]!;

  String get value {
    return _mapValue[this]!;
  }

  Map<SingingCharacter, String> _mapName(context) => {
        SingingCharacter.waiting: S.of(context).waiting,
        SingingCharacter.matched: S.of(context).matched,
        SingingCharacter.all: S.of(context).all,
        SingingCharacter.cancel: S.of(context).cancelled,
      };

  Map<SingingCharacter, String> get _mapValue => {
        SingingCharacter.waiting: ",1,ALL",
        SingingCharacter.matched: ',2,ALL',
        SingingCharacter.all: ',ALL,ALL',
        SingingCharacter.cancel: ',3,ALL',
      };
}

enum inOrderHisTabs { all, waiting, matched, fixed, cancel }

extension inOrderHisTabsExt on inOrderHisTabs {
  String name(BuildContext context) => _mapName(context)[this]!;

  get value {
    return _mapValue[this];
  }

  Map<inOrderHisTabs, String> _mapName(BuildContext context) => {
        inOrderHisTabs.waiting: S.of(context).waiting,
        inOrderHisTabs.matched: S.of(context).matched,
        inOrderHisTabs.all: S.of(context).all,
        inOrderHisTabs.cancel: S.of(context).cancelled,
        inOrderHisTabs.fixed: S.of(context).edited,
      };

  Map<inOrderHisTabs, String> get _mapValue => {
        inOrderHisTabs.waiting: "P",
        inOrderHisTabs.matched: 'M',
        inOrderHisTabs.all: '',
        inOrderHisTabs.cancel: 'X',
        inOrderHisTabs.fixed: 'C',
      };
}

enum OderCmd { all,buy, sell }

extension OderCmdExt on OderCmd {
  String name(BuildContext context) {
    switch (this) {
      case OderCmd.buy:
        return S.of(context).buy;
      case OderCmd.sell:
        return S.of(context).sell;
      case OderCmd.all:
        return S.of(context).all;
    }
  }

  String get value {
    switch (this) {
      case OderCmd.buy:
        return "B";
      case OderCmd.sell:
        return "S";
      case OderCmd.all:
        return "";
    }
  }
}

enum OderType { inDay, history, confirmOrder }

extension OderTypeExt on OderType {
  String name(BuildContext context) {
    switch (this) {
      case OderType.inDay:
        return S.of(context).inday_order;
      case OderType.history:
        return S.of(context).order_history;
      case OderType.confirmOrder:
        return S.of(context).confirm_order;
    }
  }
}
