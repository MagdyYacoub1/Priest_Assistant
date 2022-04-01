import 'package:flutter/material.dart';

import '../../../styling.dart';

class DestinationTile extends StatelessWidget {
  const DestinationTile({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTileTapped,
    required this.loading,
    this.isThreeLine = false,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String? description;
  final Function onTileTapped;
  final bool loading;
  final bool isThreeLine;

  @override
  Widget build(BuildContext context) {
    final double horizontalGap = 10.0;
    final double leadingGap = 0.0;
    return IgnorePointer(
      ignoring: loading,
      child: ListTile(
        onTap: () => onTileTapped(),
        isThreeLine: isThreeLine,
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
        subtitle: Text(
          description!,
          style: hintTextStyle,
        ),
        trailing: loading
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: accentColor,
                ),
              )
            : Icon(
                Icons.adaptive.arrow_forward_rounded,
                color: Colors.white,
                size: 30.0,
              ),
      ),
    );
  }
}
