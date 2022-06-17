import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/styling.dart';
import 'package:priest_assistant/entities/note.dart';

class NoteTile extends StatelessWidget {
  final Note? note;

  const NoteTile({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateString =
        DateFormat.yMMMEd(context.locale.toString()).format(note!.date);
    const double elevation = 4.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: elevation),
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dateString,
                    style: hintTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                note!.content!,
                style: hintTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
