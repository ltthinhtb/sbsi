import 'package:sbsi/common/app_colors.dart';

class IndexChartResponse {
  String? marketCode;
  num? openIndex;
  List<IndexChart>? data;

  IndexChartResponse({this.marketCode, this.openIndex, this.data});

  IndexChartResponse.fromJson(Map<String, dynamic> json) {
    marketCode = json['marketCode'];
    openIndex = json['openIndex'];
    if (json['data'] != null) {
      data = <IndexChart>[];
      json['data'].forEach((v) {
        data!.add(new IndexChart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketCode'] = this.marketCode;
    data['openIndex'] = this.openIndex;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<double> get dataChart {
    List<double> dataChart = [];
    if(data != null){
    for(var e in data!){
      dataChart.add(e.cIndex?.toDouble() ?? 0);
    }}
    if(dataChart.isEmpty) return [];
    return dataChart;
  }

  double get sumChart {
    return dataChart
        .cast<double>()
        .fold(0, (pr, e) => (pr + e));
  }

  double get drawPoint {
    if(dataChart.length == 0) return 0;
    return sumChart / dataChart.length;
  }

  get colorChart {
    var cIndex = data?.last.cIndex;
    var oIndex = data?.last.oIndex;
    return cIndex! > oIndex!
        ? AppColors.increase
        : cIndex < oIndex
            ? AppColors.decrease
            : AppColors.yellow;
  }
}

class IndexChart {
  String? time;
  num? oIndex;
  num? cIndex;
  num? vol;
  num? value;

  IndexChart({this.time, this.oIndex, this.cIndex, this.vol, this.value});

  IndexChart.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    oIndex = json['oIndex'];
    cIndex = json['cIndex'];
    vol = json['vol'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['oIndex'] = this.oIndex;
    data['cIndex'] = this.cIndex;
    data['vol'] = this.vol;
    data['value'] = this.value;
    return data;
  }
}
