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


enum OderType {
  inDay,advanceOder,history
}

extension OderTypeExt on OderType {

  String get name {
    switch(this){
      case OderType.inDay:
        return 'Sổ lệnh trong ngày';
      case OderType.advanceOder:
        return 'Sổ lệnh trước ngày';
      case OderType.history:
        return 'Lịch sử lệnh';
    }
  }
}