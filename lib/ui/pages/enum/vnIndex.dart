enum Index { vn, vn30, hnx, upCom }

extension StockCodeExt on Index {
  String get name => _mapName[this] ?? "";

  String get code => _mapCode[this] ?? "";

  Map<Index, String> get _mapName => {
    Index.vn: 'VN-Index',
    Index.vn30: 'VN30-Index',
    Index.hnx: 'HNX-Index',
    Index.upCom: 'UPCOM-Index',
  };

  Map<Index, String> get _mapCode => {
    Index.vn: '10',
    Index.vn30: '11',
    Index.hnx: '02',
    Index.upCom: '03',
  };
}