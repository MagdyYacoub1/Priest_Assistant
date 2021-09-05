import 'package:flutter/material.dart';

class ChartIndicator extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final IconData icon;

  const ChartIndicator({
    Key key,
    @required this.color,
    @required this.text,
    this.size = 40,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: size,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        )
      ],
    );
  }
}
