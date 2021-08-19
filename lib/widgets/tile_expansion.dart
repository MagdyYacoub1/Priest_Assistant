import 'package:flutter/material.dart';
import 'package:priest_assistant/localization/localization_constants.dart';
import '../Styling.dart';
import '../entities/confessor.dart';

class TileExpansion extends StatelessWidget {
  final Confessor myConfessors;

  @override
  TileExpansion(this.myConfessors);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: extension_lateBoxDecoration,
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
                      '${getTranslated(context, 'email')}: Magdy.demo@mail.com',
                      style: expansionTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '${getTranslated(context, 'phone')}: ${myConfessors.phone}',
                    style: expansionTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: mediaQuery.size.width * 0.65,
                    child: Text(
                      '${getTranslated(context, 'note')}: ${myConfessors.notes}',
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
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Icon(
                        Icons.warning_amber_rounded,
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
