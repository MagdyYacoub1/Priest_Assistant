import 'package:flutter/material.dart';

import '../../../styling.dart';

class DataLine extends StatelessWidget {
  const DataLine({
    Key? key,
    required this.icon,
    required this.data,
  }) : super(key: key);

  final IconData icon;
  final String data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(width: 10.0),
        Container(
          width: size.width * 0.80,
          child: Text(
            data,
            style: expansionTextStyle,
          ),
        ),
      ],
    );
  }
}
