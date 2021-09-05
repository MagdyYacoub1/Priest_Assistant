import 'package:flutter/material.dart';

import '../Styling.dart';


class StatisticsTotalCard extends StatelessWidget {
  const StatisticsTotalCard({
    Key key,
    @required this.totalNumber,
  }) : super(key: key);

  final int totalNumber;

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
    );
  }
}
