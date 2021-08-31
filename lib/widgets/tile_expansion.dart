import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/translations/localization_constants.dart';
import '../Styling.dart';
import '../entities/confessor.dart';

class TileExpansion extends StatelessWidget {
  final Confessor myConfessors;

  @override
  TileExpansion(this.myConfessors);

  BoxDecoration gradientColorAndDirection(BuildContext context, bool late) {
    if (late) {
      if (context.locale.languageCode == languageList[1].languageCode)
        return extensionLateBoxDecorationReversed;
      else
        return extensionLateBoxDecoration;
    } else {
      if (context.locale.languageCode == languageList[1].languageCode)
        return extensionOnTimeBoxDecorationReversed;
      else
        return extensionOnTimeBoxDecoration;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: gradientColorAndDirection(context, myConfessors.isLate()),
      child: Card(
        elevation: 20,
        color: extensionColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.65,
                    child: Text(
                      '${myConfessors.email}',
                      style: expansionTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.65,
                    child: const Divider(
                      color: dividerColor,
                      endIndent: 40.0,
                      indent: 40.0,
                      thickness: 2.0,
                      height: 30.0,
                    ),
                  ),
                  Text(
                    '(${myConfessors.countryCode}) ${myConfessors.phone}',
                    style: expansionTextStyle,
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.65,
                    child: const Divider(
                      color: dividerColor,
                      endIndent: 40.0,
                      indent: 40.0,
                      thickness: 2.0,
                      height: 30.0,
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width * 0.65,
                    child: Text(
                      '${myConfessors.notes.length != 0 ? myConfessors.notes.last.content : ""}',
                      style: expansionTextStyle,
                    ),
                  ),
                ],
              ),
              Card(
                shadowColor: deepRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5.0,
                color:
                    myConfessors.isLate() == true ? Colors.red : Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        myConfessors.lateMonths().toString(),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(width: 1.0),
                      myConfessors.isLate() == true
                          ? Icon(
                              Icons.warning_amber_rounded,
                              size: 30,
                            )
                          : Icon(
                              Icons.thumb_up_off_alt,
                              size: 30,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
