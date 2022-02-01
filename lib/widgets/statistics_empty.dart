import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StatisticsEmptyState extends StatelessWidget {
  const StatisticsEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: Lottie.asset(
                'assets/animations/statisticsPerson.json',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
