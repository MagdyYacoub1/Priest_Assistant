import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:priest_assistant/styling.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    Key? key,
    required this.title,
    required this.trailingNumber,
  }) : super(key: key);

  final String title;
  final int trailingNumber;

  @override
  Widget build(BuildContext context) {
    NumberFormat f = NumberFormat("##", context.locale.toString());
    return ListTile(
      style: ListTileStyle.drawer,
      title: Text(
        title,
        style: hintTextStyle,
      ),
      trailing: Text(
        f.format(trailingNumber),
        style: hintTextStyle,
      ),
    );
  }
}
