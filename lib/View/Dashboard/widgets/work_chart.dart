import 'package:flutter/material.dart';
import 'package:hrm/core/Styles/dimension.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../core/Styles/app_color.dart';

class WorkChartWidget extends StatelessWidget {
  const WorkChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Today": 45,
      "Absent Day": 2,
      "Present Day": 48
    };

    final colorList = <Color>[
      Colors.greenAccent,
      Colors.red,
      Colors.blueAccent,
    ];
    return Card(
        // color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimension.h7)),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimension.h2 * 6, vertical: Dimension.h8),
          height: Dimension.h2 * 80,
          width: Dimension.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 500),
                  chartLegendSpacing: Dimension.h10 * 12,
                  chartRadius: Dimension.h10 * 8,
                  colorList: colorList,
                  initialAngleInDegree: 90,
                  chartType: ChartType.disc,
                  emptyColor: Colors.grey,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: false,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                  // gradientList: ---To add gradient colors---
                  // emptyColorGradient: ---Empty Color gradient---
                ),
              ),
              const Text(
                "Work Hours This Week: 40",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary),
              ),
              const Text(
                "Today’s Work Hour: 40",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary),
              )
            ],
          ),
        ));
  }
}
