import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Styling.dart';

class StatisticsPage extends StatelessWidget {
  static const routeName = "/statistics_page";

  const StatisticsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Lottie.asset(
            'assets/animations/statisticsPerson.json',
          ),
        ),
      ),
    );
  }
}
