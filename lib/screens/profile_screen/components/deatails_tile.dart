import 'package:flutter/material.dart';
import 'package:priest_assistant/styling.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      title: Text(
        "Number of late months",
        style: hintTextStyle,
      ),
      trailing: Text(
        "15",
        style: hintTextStyle,
      ),
    );
  }
}
