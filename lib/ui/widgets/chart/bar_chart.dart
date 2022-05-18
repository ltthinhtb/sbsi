import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class SimpleBarChart extends StatelessWidget {
  final List<StockData> seriesList;
  final bool? animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      [
        charts.Series<StockData, String>(
          id: 'Sales',
          domainFn: (StockData stock, _) => stock.year,
          measureFn: (StockData stock, _) => stock.stockValue,
          colorFn: (StockData stock, _) =>
              charts.ColorUtil.fromDartColor(AppColors.primary),
          fillColorFn: (StockData pollution, _) {
            return charts.ColorUtil.fromDartColor(AppColors.primary);
          },
          labelAccessorFn: (StockData sales, _) =>
              '${sales.stockValue.toString()}',
          //column color.
          data: seriesList,
        ),
      ],
      primaryMeasureAxis: axis,
      domainAxis: charts.OrdinalAxisSpec(
          showAxisLine: true,
          renderSpec: new charts.SmallTickRendererSpec(
              // Tick and Label styling here.
              labelStyle: charts.TextStyleSpec(
                  fontSize: 12, // size in Pts.
                  color: charts.ColorUtil.fromDartColor(
                      const Color.fromRGBO(177, 177, 177, 1))),
              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                color: charts.ColorUtil.fromDartColor(
                    const Color.fromRGBO(177, 177, 177, 1)),
              ))),
      animate: animate ?? true,
      defaultInteractions: true,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 2,
        cornerStrategy: const charts.ConstCornerStrategy(3),
      ),
    );
  }

  final axis = charts.NumericAxisSpec(
    tickProviderSpec:
        const charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
    showAxisLine: false,
    renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(AppColors.textBlack),
            fontSize: 14),
        lineStyle: new charts.LineStyleSpec(
          dashPattern: [4],
          color: charts.ColorUtil.fromDartColor(Colors.transparent),
          thickness: 1,
        )),
  );

  /// Create one series with sample hard coded data.
}

/// Sample ordinal data type.
class StockData {
  final String year;
  final double stockValue;

  StockData(this.year, this.stockValue);
}
