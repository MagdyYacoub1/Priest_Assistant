import 'package:flutter/material.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/screens/statistics_screen/components/statistics_empty.dart';
import 'package:priest_assistant/screens/statistics_screen/components/statistics_pieChat_card.dart';
import 'package:priest_assistant/screens/statistics_screen/components/statistics_total_card.dart';

import '../../styling.dart';

class StatisticsPage extends StatefulWidget {
  static const routeName = "/statistics_page";

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late int lateNumber;
  late int onTimeNumber;
  int? totalNumber;

  @override
  void initState() {
    totalNumber = ConfessorUtilities.countConfessors();
    lateNumber = ConfessorUtilities.filterLateConfessors().length;
    onTimeNumber = totalNumber! - lateNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarPadding = 4.0 + mediaQuery.padding.top;
    double cardsSpacing = 6.0;
    return Scaffold(
      backgroundColor: mainColor,
      body: totalNumber != 0
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 10.0,
                  top: statusBarPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          alignment: AlignmentDirectional.centerStart,
                          iconSize: 30.0,
                          icon: Icon(
                            Icons.adaptive.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.only(bottom: cardsSpacing),
                      child: StatisticsTotalCard(totalNumber: totalNumber),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: cardsSpacing),
                      child: StatisticsPieChart(
                        totalNumber: totalNumber!,
                        lateNumber: lateNumber,
                        onTimeNumber: onTimeNumber,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: cardsSpacing + 10.0),
                      child: Text(
                        LocaleKeys.more_statistics_msg.tr(),
                        textAlign: TextAlign.center,
                        style: contrastTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            )
          : const StatisticsEmptyState(),
    );
  }
}
