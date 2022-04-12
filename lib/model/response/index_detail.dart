import 'dart:ui';

import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/pages/enum/vnIndex.dart';

class IndexDetail {
  num? oIndex;
  num? vol;
  num? accVol;
  String? ot;
  String? mc;
  num? cIndex;
  num? id;
  String? time;
  num? value;
  String? status;
  Index? stockCode;

  String get percent => ot!.split("|")[1];

  String get percentPrice => ot!.split("|")[0];

  Color get color => cIndex! > oIndex!
      ? AppColors.increase
      : cIndex! < oIndex!
          ? AppColors.decrease
          : AppColors.yellow;

  Color get colorChart => cIndex! > oIndex!
      ? AppColors.increase
      : cIndex! < oIndex!
          ? AppColors.decrease
          : AppColors.yellow;

  IndexDetail(
      {this.oIndex,
      this.vol,
      this.accVol,
      this.ot,
      this.mc,
      this.cIndex,
      this.id,
      this.time,
      this.value,
      this.status,
      this.stockCode});

  IndexDetail.fromJson(Map<String, dynamic> json) {
    oIndex = json['oIndex'];
    vol = json['vol'];
    accVol = json['accVol'];
    ot = json['ot'];
    mc = json['mc'];
    if (mc == Index.vn.code) {
      stockCode = Index.vn;
    }
    if (mc == Index.vn30.code) {
      stockCode = Index.vn30;
    }
    if (mc == Index.upCom.code) {
      stockCode = Index.upCom;
    }
    if (mc == Index.hnx.code) {
      stockCode = Index.hnx;
    }
    cIndex = json['cIndex'];
    id = json['id'];
    time = json['time'];
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oIndex'] = oIndex;
    data['vol'] = vol;
    data['accVol'] = accVol;
    data['ot'] = ot;
    data['mc'] = mc;
    data['cIndex'] = cIndex;
    data['id'] = id;
    data['time'] = time;
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}
