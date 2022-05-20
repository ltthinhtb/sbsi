enum SingingCharacter { all, waiting, matched, cancel }

extension SingingExt on SingingCharacter {
  get name => _mapName[this];

  value({String stockCode = ""}) {
    return _mapValue(code: stockCode)[this];
  }

  Map<SingingCharacter, String> get _mapName => {
        SingingCharacter.waiting: "Chờ khớp",
        SingingCharacter.matched: 'Đã khớp',
        SingingCharacter.all: 'Tất cả',
        SingingCharacter.cancel: 'Hủy',
      };

  Map<SingingCharacter, String> _mapValue({String code = ""}) => {
        SingingCharacter.waiting: "$code,1,ALL",
        SingingCharacter.matched: '$code,2,ALL',
        SingingCharacter.all: '$code,ALL,ALL',
        SingingCharacter.cancel: '$code,3,ALL',
      };
}

enum inOrderHisTabs { all, waiting, matched, fixed, cancel }

extension inOrderHisTabsExt on inOrderHisTabs {
  get name => _mapName[this];

  get value {
    return _mapValue[this];
  }

  Map<inOrderHisTabs, String> get _mapName => {
        inOrderHisTabs.waiting: "Chờ khớp",
        inOrderHisTabs.matched: 'Đã khớp',
        inOrderHisTabs.all: 'Tất cả',
        inOrderHisTabs.cancel: 'Hủy',
        inOrderHisTabs.fixed: 'Đã sửa',
      };

  Map<inOrderHisTabs, String> get _mapValue => {
        inOrderHisTabs.waiting: "P",
        inOrderHisTabs.matched: 'M',
        inOrderHisTabs.all: '',
        inOrderHisTabs.cancel: 'X',
        inOrderHisTabs.fixed: 'C',
      };
}

enum OderType { inDay, history }

extension OderTypeExt on OderType {
  String get name {
    switch (this) {
      case OderType.inDay:
        return 'Sổ lệnh trong ngày';
      case OderType.history:
        return 'Lịch sử lệnh';
    }
  }
}
