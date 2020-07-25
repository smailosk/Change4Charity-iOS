import 'package:bezier_chart/bezier_chart.dart';
import 'package:change4charity/ui/shared/size_config.dart';
import 'package:change4charity/viewmodels/statistics_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:random_color/random_color.dart';

class StatisticsView extends StatelessWidget {
  static final RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StatisticsViewModel>.withConsumer(
        viewModelBuilder: () => StatisticsViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          if (model.user.badHabitRecords == null) {
            return Container(
              child: Center(child: Text('No Data to Show')),
            );
          }
          final fromDate = model.user.badHabitRecords.first.dateTime;
          var toDate = model.user.badHabitRecords.last.dateTime;
          if (fromDate.compareTo(toDate) == 0) {
            toDate = toDate.add(Duration(hours: 1));
          }
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: SizeConfig.relativeHeight(75),
              width: SizeConfig.relativeWidth(100),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: SizeConfig.relativeHeight(80),
                  width: SizeConfig.relativeWidth(100),
                  child: BezierChart(
                    bezierChartScale: BezierChartScale.MONTHLY,
                    fromDate: fromDate,
                    toDate: toDate,
                    selectedDate: toDate,
                    series: List.generate(model.user.habits.length, (index) {
                      var habit = model.user.habits[index];
                      return BezierLine(
                        lineColor: _randomColor.randomMaterialColor(),
                        label: habit.name,
                        onMissingValue: (dateTime) {
                          return 0;
                        },
                        data: model
                            .getDataPoints(habit.name)
                            .map((e) => DataPoint<DateTime>(
                                value: e.totalAmount.toDouble(),
                                xAxis: e.dateTime))
                            .toList(),
                      );
                    }),
                    config: BezierChartConfig(
                      //bubbleIndicatorColor: Colors.grey,
                      verticalIndicatorStrokeWidth: 3.0,
                      verticalIndicatorColor: Colors.black26,
                      verticalLineFullHeight: false,
                      showVerticalIndicator: true,
                      showDataPoints: true,
                      verticalIndicatorFixedPosition: false,
                      backgroundColor: Colors.grey.shade600,

                      footerHeight: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
