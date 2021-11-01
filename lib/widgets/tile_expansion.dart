import 'package:flutter/cupertino.dart';
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
    //NumberFormat f = NumberFormat("##", context.locale.toString());
    final double screenPercent = 0.80;
    return Container(
      //decoration: gradientColorAndDirection(context, myConfessors.isLate()),
      child: Card(
        color: extensionColor,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          ),
        ),*/
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    width: mediaQuery.size.width * screenPercent,
                    child: Text(
                      '${myConfessors.email}',
                      style: expansionTextStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: mediaQuery.size.width * screenPercent,
                child: const Divider(
                  color: dividerColor,
                  endIndent: 40.0,
                  indent: 40.0,
                  thickness: 2.0,
                  height: 30.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.call,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    '(${myConfessors.countryCode}) ${myConfessors.phone}',
                    style: expansionTextStyle,
                  ),
                ],
              ),
              SizedBox(
                width: mediaQuery.size.width * screenPercent,
                child: const Divider(
                  color: dividerColor,
                  endIndent: 40.0,
                  indent: 40.0,
                  thickness: 2.0,
                  height: 30.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.notes,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    width: mediaQuery.size.width * screenPercent,
                    child: Text(
                      '${myConfessors.notes.length != 0 ? myConfessors.notes.last.content : ""}',
                      style: expansionTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card buildLateMonthsCard(NumberFormat f) {
    return Card(
              shadowColor:
                  myConfessors.isLate() == true ? deepRed : deepGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5.0,
              color:
                  myConfessors.isLate() == true ? Colors.red : Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      f.format(myConfessors.lateMonths()),
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(width: 1.0),
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
            );
  }
}
