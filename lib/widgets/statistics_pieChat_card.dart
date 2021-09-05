import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Styling.dart';
import 'chart_indicator.dart';

class StatisticsPieChart extends StatefulWidget {
  const StatisticsPieChart({
    Key key,
    @required this.totalNumber,
  @required this.lateNumber,
  @required this.onTimeNumber,
  }) : super(key: key);

  final int totalNumber;
  final int lateNumber;
  final int onTimeNumber;

  @override
  _StatisticsPieChartState createState() => _StatisticsPieChartState();
}

class _StatisticsPieChartState extends State<StatisticsPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      shadowColor: Colors.black87,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection.touchedSectionIndex;
                          });
                        },
                      ),
                      startDegreeOffset: -90,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: double.infinity,
                      sections: showingSections(),
                    ),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35.0),
                  ChartIndicator(
                    color:
                        touchedIndex == 0 ? deepGreen.darken(7) : deepGreen,
                    icon: Icons.thumb_up_off_alt,
                    text: "Not late",
                  ),
                  ChartIndicator(
                    color: touchedIndex == 1 ? deepRed.darken(7) : deepRed,
                    icon: Icons.warning_amber_rounded,
                    text: "Late",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (index) {
        final isTouched = index == touchedIndex;
        final fontSize = isTouched ? 30.0 : 20.0;
        final radius = isTouched ? 60.0 : 50.0;

        switch (index) {
          case 0:
            return PieChartSectionData(
              //on time confessors
              color: isTouched ? deepGreen.darken(7) : deepGreen,
              value: (widget.onTimeNumber / widget.totalNumber) * 360,
              title: widget.onTimeNumber.toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          case 1:
            return PieChartSectionData(
              //late confessors
              color: isTouched ? deepRed.darken(7) : deepRed,
              value: (widget.lateNumber / widget.totalNumber) * 360,
              title: widget.lateNumber.toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          default:
            throw Error();
        }
      },
    );
  }
}