import 'package:easy_localization/easy_localization.dart' as lo;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../entities/confessor.dart';
import '../../../entities/confessor_utilities.dart';
import '../../../entities/note.dart';
import '../../../styling.dart';
import '../../../translations/locale_keys.g.dart';

import 'note_tile.dart';

class AnimatedNotesList extends StatefulWidget {
  const AnimatedNotesList({
    Key? key,
    required this.myConfessor,
    required this.listKey,
  }) : super(key: key);

  final Confessor myConfessor;
  final GlobalKey<AnimatedListState> listKey;

  @override
  State<AnimatedNotesList> createState() => _AnimatedNotesListState();
}

class _AnimatedNotesListState extends State<AnimatedNotesList> {
  final Tween<Offset> _offsetTween = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  );

  Future<bool?> _showAlert(String content) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(LocaleKeys.are_you_sure.tr()),
          content: Text(content),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                child: Text(LocaleKeys.yes.tr()),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                child: Text(LocaleKeys.no.tr()),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onNoteDeletePressed(Confessor myConfessor, int index) async {
    if (index == myConfessor.notes.length - 1) {
      if (await _showAlert(
            LocaleKeys.note_delete_alert_content.tr(),
          ) ==
          true) {
        setState(() {
          Note temp = widget.myConfessor.notes[index];
          widget.listKey.currentState!.removeItem(
            index,
            (context, animation) => SlideTransition(
              position: _offsetTween.animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: NoteTile(
                note: temp,
              ),
            ),
            duration: Duration(milliseconds: 500),
          );
          ConfessorUtilities.deleteNote(index, myConfessor);
        });
      }
    } else {
      setState(() {
        Note temp = widget.myConfessor.notes[index];
        widget.listKey.currentState!.removeItem(
          index,
          (context, animation) => SlideTransition(
            position: _offsetTween.animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
            ),
            child: NoteTile(
              note: temp,
            ),
          ),
          duration: Duration(milliseconds: 500),
        );
        ConfessorUtilities.deleteNote(index, myConfessor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: widget.listKey,
      initialItemCount: widget.myConfessor.notes.length,
      reverse: true,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: _offsetTween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
          ),
          child: Slidable(
            //useTextDirection: false,
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.25,
              children: <Widget>[
                SlidableAction(
                  label: LocaleKeys.delete.tr(),
                  backgroundColor: backgroundRed,
                  icon: Icons.delete_rounded,
                  onPressed: (context) =>
                      onNoteDeletePressed(widget.myConfessor, index),
                ),
              ],
            ),
            child: NoteTile(
              note: widget.myConfessor.notes[index],
            ),
          ),
        );
      },
    );
  }
}
