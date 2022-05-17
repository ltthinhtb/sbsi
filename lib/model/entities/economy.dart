import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class EconomyRow {
  int? rowid;
  List<String>? data;

  EconomyRow({this.rowid, this.data});

  EconomyRow.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    data = json['data'].cast<String>();
  }

  Color get color => data!.first.contains("Bán")
      ? AppColors.active
      : data!.first.contains("Giảm")
          ? AppColors.deActive
          : AppColors.textBlack;

  Color get backGround => data?.first == 'Bán Mạnh'
      ? AppColors.Pastel2
      : data?.first == 'Giảm Mạnh'
          ? AppColors.Pastel
          : AppColors.yellow.withOpacity(0.5);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowid'] = this.rowid;
    data['data'] = this.data;
    return data;
  }
}
