import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/widgets/snackBar_widget.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/entities/note.dart';
import 'package:priest_assistant/pages/edit_page.dart';
import 'package:priest_assistant/translations/localization_constants.dart';
import 'package:priest_assistant/widgets/note_tile.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile_page";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final avatarRadius = 100.0;
  final _controller = ScrollController();
  double animatedScroll = 0.0;
  double animatedOpacity = 1.0;

  @override
  void initState() {
    _controller.addListener(onScroll);
    super.initState();
  }

  onScroll() {
    setState(() {
      animatedScroll = -_controller.offset;

      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        animatedOpacity =
            animatedOpacity + _controller.offset * 0.0001; //scroll down
      } else if (_controller.position.userScrollDirection !=
          ScrollDirection.forward) {
        animatedOpacity =
            animatedOpacity - _controller.offset * 0.0001; //scroll up
      }
      if (_controller.offset == 0.0) animatedOpacity = 1.0;
      if (_controller.offset > 150.0) animatedOpacity = 0.0;

      //Guard conditions to prevent negative and > 1 values
      if (animatedOpacity <= 0.0)
        animatedOpacity = 0.0;
      else if (animatedOpacity >= 1) animatedOpacity = 1.0;
    });
  }

  Future<bool> _showAlert(BuildContext context, String content) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.are_you_sure.tr()),
          content: Text(content),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextButton(
                child: Text(LocaleKeys.no.tr()),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                child: Text(LocaleKeys.yes.tr()),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //final scrollRange = mediaQuery.size.height * 0.25;
    final dynamic confessorKey =
        ModalRoute.of(context).settings.arguments as dynamic;
    Confessor myConfessor = ConfessorUtilities.readConfessor(confessorKey);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: -100,
            top: -140,
            child: Container(
              height: mediaQuery.size.height * 0.35,
              width: mediaQuery.size.height * 0.35,
              decoration: BoxDecoration(
                color: Color(0xFF20315F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -120,
            top: 120,
            child: Container(
              height: mediaQuery.size.height * 0.25,
              width: mediaQuery.size.height * 0.25,
              decoration: BoxDecoration(
                color: Color(0xFF20315F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1, microseconds: 500),
            curve: Curves.easeInToLinear,
            color:
                myConfessor.isLate() == true ? backgroundRed : backgroundGreen,
            height: mediaQuery.size.height * 0.33,
            width: double.infinity,
          ),
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.25,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80.0,
                      ),
                      Text(
                        myConfessor.fName + " " + myConfessor.lName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Visibility(
                        visible: myConfessor.email != "" ? true : false,
                        child: Text(
                          myConfessor.email,
                          textAlign: TextAlign.center,
                          style: hintTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: myConfessor.address != "" ? 5.0 : 0,
                      ),
                      Visibility(
                        visible: myConfessor.address != "" ? true : false,
                        child: Text(
                          myConfessor.address,
                          textAlign: TextAlign.center,
                          style: hintTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.call,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30.0,
                              icon: const FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int reversedIndex =
                              (myConfessor.notes.length - 1) - index;
                          return Slidable(
                            key: UniqueKey(),
                            actionPane: SlidableBehindActionPane(),
                            child: NoteTile(
                              note: myConfessor.notes[reversedIndex],
                            ),
                            actions: <Widget>[
                              Card(
                                elevation: 10,
                                child: IconSlideAction(
                                  caption: LocaleKeys.delete.tr(),
                                  color: backgroundRed,
                                  icon: Icons.delete_rounded,
                                  onTap: () async {
                                    if (reversedIndex ==
                                        myConfessor.notes.length - 1) {
                                      if (await _showAlert(
                                              context,
                                              LocaleKeys
                                                  .note_delete_alert_content
                                                  .tr()) ==
                                          true) {
                                        setState(() {
                                          ConfessorUtilities.deleteNote(
                                              reversedIndex, myConfessor);
                                          showSnackBar(
                                              context,
                                              LocaleKeys.recent_note_deleted
                                                  .tr());
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        ConfessorUtilities.deleteNote(
                                            reversedIndex, myConfessor);
                                        showSnackBar(context,
                                            LocaleKeys.note_deleted.tr());
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: myConfessor.notes.length,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Opacity(
            opacity: animatedOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 23.0),
                  child: IconButton(
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 23.0),
                  child: PopupMenuButton<int>(
                    onSelected: (value) async {
                      switch (value) {
                        case 1:
                          showBottomSheet(context, myConfessor);
                          break;
                        case 2:
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPage(
                                confessorKey: confessorKey,
                              ),
                            ),
                          );
                          break;
                        case 3:
                          if (await _showAlert(
                                  context,
                                  LocaleKeys.confessor_delete_alert_content
                                      .tr()) ==
                              true) {
                            ConfessorUtilities.deleteConfessor(myConfessor);
                            showSnackBar(
                                context, LocaleKeys.confessor_deleted.tr());
                            Navigator.of(context).pop();
                          }
                          break;
                      }
                    },
                    enableFeedback: true,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    iconSize: 30.0,
                    elevation: 10,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.update_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(LocaleKeys.renew_confession.tr()),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.account_box_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(LocaleKeys.update_date.tr()),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(LocaleKeys.delete_confessor.tr()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: (context.locale.languageCode == Arabic)
                ? Offset(
                    (-mediaQuery.size.width / 2) + avatarRadius,
                    (mediaQuery.size.height * 0.25) -
                        avatarRadius +
                        animatedScroll)
                : Offset(
                    (mediaQuery.size.width / 2) - avatarRadius,
                    (mediaQuery.size.height * 0.25) -
                        avatarRadius +
                        animatedScroll),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: avatarRadius,
              child: Hero(
                transitionOnUserGestures: true,
                tag: myConfessor.toString(),
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  radius: avatarRadius - 15,
                  backgroundImage: myConfessor.photo != null
                      ? MemoryImage(
                          myConfessor.photo,
                        )
                      : null,
                  child: myConfessor.photo == null
                      ? Icon(
                          Icons.person,
                          size: avatarRadius - 15,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context, Confessor myConfessor) {
    String _note;
    TextEditingController _dateController = new TextEditingController();
    DateTime datePicked = new DateTime.now();
    String dateString =
        DateFormat.yMMMEd(context.locale.toString()).format(datePicked);
    _dateController.text = dateString;
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          //height: 330,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                top: 30.0,
                left: 15.0,
                right: 15.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    LocaleKeys.note.tr(),
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    maxLines: 2,
                    onSaved: (value) {
                      value.trim();
                      _note = value;
                    },
                    decoration: bottomSheetInputDecoration(
                        LocaleKeys.note_optional_hint.tr()),
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.confession_date.tr(),
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 3.0,
                          color: Colors.green,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          showRoundedDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime(DateTime.now().year + 10),
                            borderRadius: 16,
                            onTapDay: (chosenDate, available) {
                              String dateString =
                                  DateFormat.yMMMEd().format(chosenDate);
                              _dateController.text = dateString;
                              datePicked = chosenDate;
                              //print(datePicked.toString());
                              return available;
                            },
                          );
                        },
                        color: accentColor,
                        iconSize: 32,
                        icon: Icon(Icons.calendar_today_rounded),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(accentColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(color: accentColor),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _formKey.currentState.save();
                          setState(() {
                            myConfessor.lastConfessDate = datePicked;
                            myConfessor.notes
                                .add(Note(content: _note, date: datePicked));
                            showSnackBar(
                                context, LocaleKeys.confession_renewed.tr());
                            Navigator.pop(context);
                          });
                          ConfessorUtilities.renewConfession(myConfessor);
                        },
                        child: Text(
                          LocaleKeys.renew.tr(),
                          style: contrastTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
