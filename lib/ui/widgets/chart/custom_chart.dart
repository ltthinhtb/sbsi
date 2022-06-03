import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../utils/stock_color.dart';

class CustomLineChart extends StatefulWidget {
  CustomLineChart({
    Key? key,
    required this.data,
    this.animate = false,
    required this.color,
    this.dashPattern,
    this.enableArea,
    required this.drawPoint,
  }) : super(key: key);
  final List<double> data;

  /// list data
  final bool animate;
  final Color color;
  final bool? enableArea;
  final List<int>? dashPattern;

  /// màu của chart
  final double drawPoint;

  /// điểm cắt ở ngang

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  late List<charts.Series<double, int>> seriesList;
  late List<charts.Series<double, int>> areaSeriesList;
  late Color lineColor;
  late MaterialColor chartColor;
  late num highestValue;
  late num lowestValue;
  late num distance;

  @override
  void initState() {
    super.initState();
    setState(() {
      highestValue = [widget.data.reduce(max), widget.drawPoint].reduce(max);
      lowestValue = [widget.data.reduce(min), widget.drawPoint].reduce(min);
      distance = highestValue - lowestValue;
      seriesList = generateSeriesList(widget.data);
      areaSeriesList = generateAreaSeriesList(widget.data);
      lineColor = widget.color;
      chartColor = MaterialColor(widget.color.value, getSwatch(widget.color));
    });
  }

  @override
  void didUpdateWidget(covariant CustomLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.color != widget.color) ||
        oldWidget.data.length != seriesList.length) {
      setState(() {
        highestValue = [widget.data.reduce(max), widget.drawPoint].reduce(max);
        lowestValue = [widget.data.reduce(min), widget.drawPoint].reduce(min);
        distance = highestValue - lowestValue;
        seriesList = generateSeriesList(widget.data);
        areaSeriesList = generateAreaSeriesList(widget.data);
        lineColor = widget.color;
        chartColor = MaterialColor(widget.color.value, getSwatch(widget.color));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true, // disable selection
      child: Stack(
        children: [
          // area chart
          Visibility(
              visible: widget.enableArea != false,
              child: Container(
                // color: Colors.white,
                child: charts.LineChart(
                  areaSeriesList,
                  animate: false,
                  layoutConfig: charts.LayoutConfig(
                    leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                    topMarginSpec: charts.MarginSpec.fixedPixel(0),
                    rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                    bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    showAxisLine: false,
                    viewport:
                    charts.NumericExtents(lowestValue, highestValue),
                    renderSpec: const charts.NoneRenderSpec(),
                    tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                      zeroBound: false,
                    ),
                  ),
                  domainAxis: const charts.NumericAxisSpec(
                    showAxisLine: false,
                    renderSpec: charts.NoneRenderSpec(),
                    tickProviderSpec: charts.BasicNumericTickProviderSpec(
                      zeroBound: false,
                    ),
                  ),
                  defaultRenderer: charts.LineRendererConfig(
                    includeArea: true,
                    areaOpacity: 0.3,
                  ),
                  behaviors: [
                    charts.RangeAnnotation([
                      charts.LineAnnotationSegment(
                        widget.drawPoint,
                        charts.RangeAnnotationAxisType.measure,
                        color:
                        charts.ColorUtil.fromDartColor(const Color(0xff93969A)),
                        // dòng cắt ngang
                        dashPattern: widget.dashPattern ?? [5, 5],
                        strokeWidthPx: 1,
                      )
                    ])
                  ],
                ),
              )),

          //Đổ màu
          Container(
            // color: greenColor.shade400,
            child: charts.LineChart(
              seriesList,
              animate: false,
              layoutConfig: charts.LayoutConfig(
                leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                topMarginSpec: charts.MarginSpec.fixedPixel(0),
                rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                showAxisLine: false,
                viewport: charts.NumericExtents(lowestValue, highestValue),
                renderSpec: const charts.NoneRenderSpec(),
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
              ),
              domainAxis: const charts.NumericAxisSpec(
                showAxisLine: false,
                renderSpec: charts.NoneRenderSpec(),
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                ),
              ),
              defaultRenderer: charts.LineRendererConfig(
                includeArea: false,
              ),
              behaviors: [
                charts.RangeAnnotation([
                  charts.LineAnnotationSegment(
                    widget.drawPoint,
                    charts.RangeAnnotationAxisType.measure,
                    color: charts.ColorUtil.fromDartColor(const Color(0xff93969A)),
                    dashPattern: widget.dashPattern ?? [5, 5],
                    strokeWidthPx: 1,
                  )
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<charts.Series<double, int>> generateSeriesList(List<double> data) {
    return [
      charts.Series<double, int>(
        id: 'Line',
        strokeWidthPxFn: (_, __) => 1,
        radiusPxFn: (_, __) => 1,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(widget.color),
        domainFn: (_, index) => index ?? 0,
        measureFn: (value, _) => value,
        data: data,
      ),
    ];
  }

  // vùng hiển thị
  List<charts.Series<double, int>> generateAreaSeriesList(List<double> data) {
    return [
      charts.Series<double, int>(
        id: 'Area',
        strokeWidthPxFn: (_, __) => 1,
        radiusPxFn: (_, __) => 1,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(widget.color.withOpacity(0.3)),
        domainFn: (_, index) => index ?? 0,
        measureFn: (value, _) => value,
        data: data,
      ),
    ];
  }

  List<double> get stops => [
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.8,
    0.9,
  ];
}

class LineColor {
  static Color fromStockColor(StockPrice color) {
    switch (color) {
      case StockPrice.increase:
        return AppColors.increase;
      case StockPrice.r:
        return AppColors.increase;
      case StockPrice.decrease:
        return AppColors.decrease;
      case StockPrice.c:
        return AppColors.ceil;
      case StockPrice.f:
        return AppColors.floor;
      default:
        return AppColors.increase;
    }
  }
}

class AreaColor {
  static MaterialColor fromStockColor(StockPrice color) {
    switch (color) {
      case StockPrice.increase:
        return MaterialColor(
            AppColors.increase.value, getSwatch(AppColors.increase));
      case StockPrice.r:
        return MaterialColor(
            AppColors.yellow.value, getSwatch(AppColors.yellow));
      case StockPrice.decrease:
        return MaterialColor(
            AppColors.decrease.value, getSwatch(AppColors.decrease));
      case StockPrice.c:
        return MaterialColor(AppColors.ceil.value, getSwatch(AppColors.ceil));
      case StockPrice.f:
        return MaterialColor(AppColors.floor.value, getSwatch(AppColors.floor));
      default:
        return MaterialColor(
            AppColors.increase.value, getSwatch(AppColors.increase));
    }
  }
}

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}
