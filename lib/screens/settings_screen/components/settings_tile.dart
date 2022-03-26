import 'package:flutter/material.dart';

import '../../../styling.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required this.title,
    this.description,
    required this.icon,
    required this.chosenValue,
    required this.optionsList,
    required this.onOptionSelected,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String? description;
  final String chosenValue;
  final List<PopupMenuEntry<int>> optionsList;
  final Function(int) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    double horizontalGap = 10.0;
    double leadingGap = 0.0;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: horizontalGap,
      minLeadingWidth: leadingGap,
      leading: Icon(
        icon,
        color: Colors.white,
        size: 30.0,
      ),
      title: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
        ),
        child: Text(
          title,
          style: contrastTextStyle,
        ),
      ),
      subtitle: description != null
          ? Text(
              description!,
              style: hintTextStyle,
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chosenValue,
            style: contrastTextStyle,
          ),
          PopupMenuButton<int>(
            onSelected: (value) => onOptionSelected(value),
            enableFeedback: true,
            itemBuilder: (context) => optionsList,
            offset: Offset(0.0, 40.0),
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
