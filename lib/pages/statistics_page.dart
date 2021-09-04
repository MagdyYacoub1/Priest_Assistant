import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';

import '../Styling.dart';

class StatisticsPage extends StatefulWidget {
  static const routeName = "/statistics_page";

  const StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int lateNumber;
  int onTimeNumber;
  int totalNumber;
  int touchedIndex = -1;

  @override
  void initState() {
    totalNumber = ConfessorUtilities.countConfessors();
    lateNumber = ConfessorUtilities.filterLateConfessors().length;
    onTimeNumber = totalNumber - lateNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: totalNumber != 0
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          iconSize: 30.0,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        shadowColor: Colors.black87,
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "The total number of confessors",
                                  style: headerTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  totalNumber.toString(),
                                  style: numberTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black87,
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      setState(() {
                                        if (!event
                                                .isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection ==
                                                null) {
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
                                swapAnimationDuration:
                                    Duration(milliseconds: 150),
                                // Optional
                                swapAnimationCurve: Curves.linear, // Optional
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Lottie.asset(
                  'assets/animations/statisticsPerson.json',
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
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        final widgetSize = isTouched ? 55.0 : 40.0;

        switch (index) {
          case 0:
            return PieChartSectionData(
              //on time confessors
              color: deepGreen,
              value: (onTimeNumber / totalNumber) * 360,
              title: onTimeNumber.toString(),
              radius: radius,
              badgeWidget: Icon(
                Icons.thumb_up_off_alt,
                color: deepGreen.darken(40),
                size: widgetSize,
              ),
              badgePositionPercentageOffset: 1.0,
              titlePositionPercentageOffset: 0.3,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          case 1:
            return PieChartSectionData(
              //late confessors
              color: deepRed,
              value: (lateNumber / totalNumber) * 360,
              title: lateNumber.toString(),
              radius: radius,
              badgeWidget: Icon(
                Icons.warning_amber_rounded,
                color: deepRed.darken(40),
                size: widgetSize,
              ),
              badgePositionPercentageOffset: .98,
              titlePositionPercentageOffset: 0.4,
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
