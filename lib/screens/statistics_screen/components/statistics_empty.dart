import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';

import '../../../styling.dart';

class StatisticsEmptyState extends StatelessWidget {
  const StatisticsEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                IconButton(
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
            SizedBox(height: size.height * 0.1),
            Container(
              width: size.width,
              height: size.height * 0.4,
              child: Lottie.asset(
                'assets/animations/statisticsPerson.json',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              LocaleKeys.no_confessors_yet.tr(),
              style: contrastTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
