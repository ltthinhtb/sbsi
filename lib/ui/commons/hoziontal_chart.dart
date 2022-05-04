import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as common;
import 'package:sbsi/common/app_colors.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<ChartData> seriesList;
  final bool animate;
  final num maxVol;
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  HorizontalBarChart(
      {this.animate = true, required this.seriesList, required this.maxVol});

  /// Creates a [BarChart] with sample data and no transition.

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.

    return charts.BarChart(
      [
        charts.Series<ChartData, String>(
          id: 'Sales',
          colorFn: (ChartData sales, _) => sales.color == "red"
              ? const Color(b: 92, r: 245, g: 70)
              : sales.color == "green"
                  ? const Color(b: 107, r: 3, g: 202)
                  : const Color(b: 39, r: 252, g: 201),
          domainFn: (ChartData sales, _) => sales.lastPrice.toString(),
          measureFn: (ChartData sales, _) => double.parse(sales.vol),
          data: seriesList,
        )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
      ],
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 0.5,
      ),
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
      primaryMeasureAxis: axis,
      domainAxis:  common.AxisSpec<String>(
          renderSpec: charts.SmallTickRendererSpec(
        labelStyle: const charts.TextStyleSpec(
          color: charts.MaterialPalette.black,
        ),
            lineStyle: charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(AppColors.textGrey4),
            )
      )),
      secondaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(AppColors.textBlack),
                fontSize: 14),
            lineStyle: new charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(AppColors.textGrey),
              dashPattern: [4]
            ),
            axisLineStyle: new charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(AppColors.textGrey),
            )
            //chnage white color as per your requirement.
          ),
          tickFormatterSpec: BasicNumericTickFormatterSpec(
              (value) => (value)!.toStringAsFixed(0).toString() + "K"),
          showAxisLine: true,
          tickProviderSpec:
              const charts.BasicNumericTickProviderSpec(desiredTickCount: 4)),
    );
  }

  final axis = charts.NumericAxisSpec(
    renderSpec: charts.SmallTickRendererSpec(
        labelStyle: const charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
        ),
        lineStyle: new charts.LineStyleSpec(
          color: charts.ColorUtil.fromDartColor(AppColors.textGrey),
        )),
  );

  /// Create one series with sample hard coded data.
}

/// Sample ordinal data type.
class ChartData {
  final String vol;
  final num lastPrice;
  final String color;

  ChartData(this.vol, this.lastPrice, this.color);
}
