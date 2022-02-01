import 'package:flutter/material.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../Styling.dart';


class StatisticsTotalCard extends StatelessWidget {
  const StatisticsTotalCard({
    Key? key,
    required this.totalNumber,
  }) : super(key: key);

  final int? totalNumber;

  @override
  Widget build(BuildContext context) {
    NumberFormat f = NumberFormat( "##", context.locale.toString());
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
          child: Column(
            children: [
              Text(
                LocaleKeys.total_card_msg.tr(),
                style: headerTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15.0),
              Text(
                f.format(totalNumber),
                style: numberTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
