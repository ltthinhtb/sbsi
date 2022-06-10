import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class TotalAssets {
  String? totalNav;
  String? totalCash;
  String? totalEnquity;
  String? vmEnquity;
  String? vmEnquityPer;
  List<ListAssets>? listAssets;

  bool get isIncrease {
    if(vmEnquityPer?.contains("-") ?? true){
      return false;
    }
    return true;
  }

  Color get color {
    if(isIncrease) {
      return AppColors.active;
    }
    return AppColors.deActive;
  }

  TotalAssets(
      {this.totalNav,
      this.totalCash,
      this.totalEnquity,
      this.vmEnquity,
      this.vmEnquityPer,
      this.listAssets});

  TotalAssets.fromJson(Map<String, dynamic> json) {
    totalNav = json['total_nav'];
    totalCash = json['total_cash'];
    totalEnquity = json['total_enquity'];
    vmEnquity = json['vm_enquity'];
    vmEnquityPer = json['vm_enquity_per'];
    if (json['listAssets'] != null) {
      listAssets = <ListAssets>[];
      json['listAssets'].forEach((v) {
        listAssets!.add(new ListAssets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_nav'] = this.totalNav;
    data['total_cash'] = this.totalCash;
    data['total_enquity'] = this.totalEnquity;
    data['vm_enquity'] = this.vmEnquity;
    data['vm_enquity_per'] = this.vmEnquityPer;
    if (this.listAssets != null) {
      data['listAssets'] = this.listAssets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListAssets {
  String? type;
  String? percentNav;
  String? nav;
  String? cash;

  ListAssets({this.type, this.percentNav, this.nav, this.cash});

  ListAssets.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    percentNav = json['percent_nav'];
    nav = json['nav'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['percent_nav'] = this.percentNav;
    data['nav'] = this.nav;
    data['cash'] = this.cash;
    return data;
  }
}
