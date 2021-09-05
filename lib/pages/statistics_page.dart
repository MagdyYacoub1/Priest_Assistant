import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/widgets/statistics_empty.dart';
import 'package:priest_assistant/widgets/statistics_pieChat_card.dart';
import 'package:priest_assistant/widgets/statistics_total_card.dart';

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

  @override
  void initState() {
    totalNumber = ConfessorUtilities.countConfessors();
    lateNumber = ConfessorUtilities.filterLateConfessors().length;
    onTimeNumber = totalNumber - lateNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double cardsSpacing = 6.0;
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
                      padding: EdgeInsets.only(bottom: cardsSpacing),
                      child: StatisticsTotalCard(totalNumber: totalNumber),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: cardsSpacing),
                      child: StatisticsPieChart(
                        totalNumber: totalNumber,
                        lateNumber: lateNumber,
                        onTimeNumber: onTimeNumber,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: cardsSpacing + 10.0),
                      child: Text("More statistics cards will be added in the future",
                      textAlign: TextAlign.center,
                        style: contrastTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            )
          : const StatisticsEmptyState()
    );
  }
}
