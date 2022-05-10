import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/model/response/market_depth_response.dart';

class MarketDepthBarChart extends StatelessWidget {
  MarketDepthBarChart({Key? key, required this.data}) : super(key: key);
  final double widthBar = 24;
  final List<MarketDepth> data;

  @override
  Widget build(BuildContext context) {
    var max = data.first.sL ?? 0;
    for (var i = 0; i < data.length; i++) {
      if ((data[i].sL ?? 0) > max) max = (data[i].sL ?? 0);
    }
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups(),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: max.toDouble(),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              AppTextStyle.H6Bold.copyWith(
                color: group.x < 5
                    ? AppColors.red.withOpacity(0.9)
                    : group.x > 5
                        ? AppColors.green.withOpacity(0.9)
                        : AppColors.yellow.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = "<=-7%";
        break;
      case 1:
        text = "-7--5%";
        break;
      case 2:
        text = "-5--3%";
        break;
      case 3:
        text = "-3--1%";
        break;
      case 4:
        text = "-1--0%";
        break;
      case 5:
        text = "0%";
        break;
      case 6:
        text = "0-1%";
        break;
      case 7:
        text = "1-3%";
        break;
      case 8:
        text = "3-5%";
        break;
      case 9:
        text = "5-7%";
        break;
      case 10:
        text = ">=7%";
        break;
      default:
        text = '';
        break;
    }
    return Center(
        child: Text(text,
            style: AppTextStyle.H7Regular.copyWith(
                color: AppColors.grayBorder, fontSize: 7)));
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient _barsGradient(Color color) {
    return LinearGradient(
      colors: [
        color.withOpacity(0.0),
        color.withOpacity(0.1),
        color.withOpacity(0.2),
        color.withOpacity(0.3),
        color.withOpacity(0.4),
        color.withOpacity(0.5),
        color.withOpacity(0.6),
        color.withOpacity(0.7),
        color.withOpacity(0.8),
        color.withOpacity(0.9),
      ],
      stops: stops,
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }

  List<double> get stops => [
        0.0,
        0.1,
        0.2,
        0.3,
        0.4,
        0.5,
        0.6,
        0.7,
        0.8,
        0.9,
      ];

  List<BarChartGroupData> barGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < data.length; i++) {
      barGroups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
              toY: data[i].sL?.toDouble() ?? 0,
              borderRadius: const BorderRadius.only(
                  topRight: const Radius.circular(5), topLeft: const Radius.circular(5)),
              gradient: _barsGradient(i < 5
                  ? AppColors.red
                  : i > 5
                      ? AppColors.green
                      : AppColors.yellow),
              width: widthBar)
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return barGroups;
  }
}
