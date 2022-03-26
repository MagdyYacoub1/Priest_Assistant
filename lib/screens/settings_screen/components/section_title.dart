import 'package:flutter/material.dart';

import '../../../styling.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          style: headerTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
