import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class SimpleBarChart extends StatelessWidget {
  final List<StockData> seriesList;
  final bool? animate;
  final int? toStringAsFixed;

  SimpleBarChart(this.seriesList, {this.animate, this.toStringAsFixed = 0});

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
          labelAccessorFn: (StockData sales, _) {
            return '${sales.stockValue.toStringAsFixed(toStringAsFixed!)}';
          },
          outsideLabelStyleAccessorFn: (StockData sales, _) {
            return new charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(AppColors.textBlack));
          },
          //column color.
          data: seriesList,
        ),
      ],
      primaryMeasureAxis: axis,
      domainAxis: charts.OrdinalAxisSpec(
          showAxisLine: true,
          renderSpec: new charts.SmallTickRendererSpec(
            tickLengthPx: 1,
            axisLineStyle: charts.LineStyleSpec(
                color: charts.ColorUtil.fromDartColor(
                    const Color.fromRGBO(177, 177, 177, 1)),
                thickness: 1),
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, // size in Pts.
                color: charts.ColorUtil.fromDartColor(
                    const Color.fromRGBO(177, 177, 177, 1))),
          )),
      animate: animate ?? true,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );
  }

  final axis = charts.NumericAxisSpec(
    tickProviderSpec:
        const charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
    showAxisLine: true,
    renderSpec: charts.SmallTickRendererSpec(
        labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(AppColors.textBlack),
            fontSize: 16),
        tickLengthPx: 5,
        axisLineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(
                const Color.fromRGBO(177, 177, 177, 1)),
            thickness: 1),
        lineStyle: new charts.LineStyleSpec(
          dashPattern: [4],
          color: charts.ColorUtil.fromDartColor(
              const Color.fromRGBO(177, 177, 177, 1)),
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
