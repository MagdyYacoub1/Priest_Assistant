import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:priest_assistant/input_settings.dart';
import 'package:priest_assistant/styling.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/widgets/snackBar_widget.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/entities/note.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:priest_assistant/translations/localization_constants.dart';

import '../../entities/utilities.dart';
import '../profile_screen/profile_page.dart';

enum ScreenMode {
  add,
  edit,
}

enum CalenderType {
  birthday,
  confessionDate,
}

class AddEditPage extends StatefulWidget {
  static const routeName = "/addPage_page";

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final avatarRadius = 80.0;
  DateTime? confessionDatePicked;
  DateTime? birthDatePicked;
  bool initialBuild = true;
  late ScreenMode screenMode;
  late TextEditingController _confessionDateController;
  late TextEditingController _birthDateController;
  Confessor? updateConfessor;
  final _formKey = GlobalKey<FormState>();

  Uint8List? _image;
  String? _fName;
  String? _lName;
  String? _address;
  String? _phoneNumber;
  String? _countryCode;
  String? _email;
  String? _note;

  void initDateField(BuildContext context) {
    //initialize the confession date string with the today date
    confessionDatePicked = DateTime.now();
    AppUtilities.getLongDate(context.locale, confessionDatePicked!);
    String? dateString =
        AppUtilities.getLongDate(context.locale, confessionDatePicked!);
    _confessionDateController = TextEditingController(text: dateString);

    //initialize the birthday date string if available
    if (updateConfessor?.birthDate != null) {
      dateString = AppUtilities.getShortDate(
          context.locale, updateConfessor!.birthDate!);
    } else {
      dateString = null;
    }
    _birthDateController = TextEditingController(text: dateString);

    //initialize the image if available
    _image = updateConfessor?.photo;
    initialBuild = false;
  }

  bool isValidPhone(String phone) {
    final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return phoneRegExp.hasMatch(phone);
  }

  void calendarPressed({
    required CalenderType type,
    required DateTime initialDate,
    required DateTime startDate,
    required DateTime endDate,
    required DatePickerMode mode,
    required String description,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    DateTime? datePicked = await showRoundedDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: startDate,
      lastDate: endDate,
      theme: myTheme.copyWith(accentColor: accentColor),
      imageHeader: AssetImage("assets/images/datePickerHeader.jpg"),
      description: description,
      initialDatePickerMode: mode,
      borderRadius: 16,
    );
    if (type == CalenderType.birthday) {
      birthDatePicked = datePicked;
      if (birthDatePicked != null) {
        String dateString =
            AppUtilities.getShortDate(context.locale, birthDatePicked!);
        _birthDateController.text = dateString;
      } else {
        _birthDateController.text = '';
      }
    } else {
      confessionDatePicked = datePicked == null ? DateTime.now() : datePicked;
      String dateString = DateFormat.yMMMEd(context.locale.toString())
          .format(confessionDatePicked!);
      _confessionDateController.text = dateString;
    }
  }

  void readImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? photo = await _picker.pickImage(
      source: source,
    );
    if (photo == null) return;
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: photo.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxWidth: 200,
      maxHeight: 200,
      compressFormat: ImageCompressFormat.jpg,
      cropStyle: CropStyle.circle,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: accentColor,
        toolbarTitle: LocaleKeys.crop_image.tr(),
        statusBarColor: themeColor,
        backgroundColor: accentColor,
        activeControlsWidgetColor: accentColor,
      ),
    );
    if (croppedImage == null) return;
    Uint8List bytes = File(croppedImage.path).readAsBytesSync();
    setState(() {
      _image = bytes;
    });
  }

  void saveForm(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      if (screenMode == ScreenMode.add) {
        Confessor newConfessor = new Confessor(
          photo: _image,
          fName: _fName!,
          lName: _lName!,
          address: _address,
          email: _email,
          phone: _phoneNumber!,
          countryCode: _countryCode!,
          notes: [Note(content: _note, date: confessionDatePicked!)],
          lastConfessDate: confessionDatePicked!,
          birthDate: birthDatePicked,
        );
        ConfessorUtilities.addConfessor(newConfessor);
        showSnackBar(context, LocaleKeys.confessor_added_msg.tr());
        Navigator.pop(context);
      } else {
        updateConfessor!.photo = _image;
        updateConfessor!.fName = _fName!;
        updateConfessor!.lName = _lName!;
        updateConfessor!.address = _address;
        updateConfessor!.email = _email;
        updateConfessor!.phone = _phoneNumber!;
        updateConfessor!.countryCode = _countryCode!;
        ConfessorUtilities.editConfessor(updateConfessor!);
        showSnackBar(context, LocaleKeys.confessor_updated.tr());
        Navigator.of(context).popAndPushNamed(ProfilePage.routeName,
            arguments: updateConfessor!.key);
      }
    }
  }

  void _onBackPressed() {
    if (screenMode == ScreenMode.edit) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(LocaleKeys.are_you_sure.tr()),
            content: Text(LocaleKeys.exit_edit_alert_content.tr()),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  child: Text(LocaleKeys.yes.tr()),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).popAndPushNamed(ProfilePage.routeName,
                        arguments: updateConfessor!.key);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  child: Text(LocaleKeys.stay.tr()),
                  onPressed: () {
                    Navigator.pop(context);
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
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _confessionDateController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarPadding = 4.0 + mediaQuery.padding.top;
    final dynamic updateConfessorKey =
        ModalRoute.of(context)!.settings.arguments as dynamic;
    updateConfessor = ConfessorUtilities.readConfessor(updateConfessorKey);
    if (updateConfessor != null) {
      screenMode = ScreenMode.edit;
    } else {
      screenMode = ScreenMode.add;
    }
    //initialize dates only one time //TODO: update this initialization using provider
    if (initialBuild) initDateField(context);

    return Scaffold(
      backgroundColor: mainColor,
      body: WillPopScope(
        onWillPop: () async => screenMode == ScreenMode.edit ? false : true,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
                top: statusBarPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        alignment: AlignmentDirectional.centerStart,
                        iconSize: 30.0,
                        icon: Icon(
                          Icons.adaptive.arrow_back_rounded,
                          color: Colors.white,
                        ),
                        onPressed: _onBackPressed,
                      ),
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
                        onPressed: () => saveForm(context),
                        child: Text(
                          LocaleKeys.save.tr(),
                          style: contrastTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: (context.locale.languageCode == Arabic)
                        ? Offset(
                            (-mediaQuery.size.width / 2) + avatarRadius + 20,
                            (mediaQuery.size.height * 0.12) - avatarRadius)
                        : Offset(
                            (mediaQuery.size.width / 2) - avatarRadius - 20,
                            (mediaQuery.size.height * 0.12) - avatarRadius),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: avatarRadius,
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: avatarRadius - 15,
                          backgroundImage: _image != null
                              ? MemoryImage(
                                  _image!,
                                )
                              : null,
                          child: _image == null
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: accentColor,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    LocaleKeys.full_name.tr(),
                    style: contrastTextStyle,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: updateConfessor?.fName,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              InputSettings.validator.firstNameValidator(value),
                          onSaved: (value) {
                            value = value!.trim();
                            _fName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: LocaleKeys.first_name.tr(),
                            hintStyle: hintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          initialValue: updateConfessor?.lName,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => InputSettings.validator
                              .secondNameValidator(value),
                          onSaved: (value) {
                            value = value!.trim();
                            _lName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: LocaleKeys.last_name.tr(),
                            hintStyle: hintTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.address.tr(),
                    style: contrastTextStyle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: updateConfessor?.address,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    onSaved: (value) {
                      value = value!.trim();
                      _address = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: LocaleKeys.full_address_hint.tr(),
                      hintStyle: hintTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.phone.tr(),
                    style: contrastTextStyle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: updateConfessor?.phone,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (phone) {
                      phone = phone!.trim();
                      if (phone.isEmpty)
                        return LocaleKeys.phone_number_error_msg.tr();
                      else if (!isValidPhone(phone))
                        return LocaleKeys.valid_phone_error_msg.tr();
                      else
                        return null;
                    },
                    onSaved: (value) {
                      value = value!.trim();
                      _phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: CountryCodePicker(
                        initialSelection: context.locale.countryCode,
                        favorite: ["EG", "US"],
                        onInit: (value) {
                          _countryCode =
                              context.locale.countryCode == 'US' ? "+1" : "+20";
                        },
                        onChanged: (countryCode) {
                          _countryCode = countryCode.dialCode;
                          print(_countryCode);
                        },
                      ),
                      hintText: LocaleKeys.phone_number.tr(),
                      hintStyle: hintTextStyle,
                    ),
                    //
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.birth_date.tr(),
                    style: contrastTextStyle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _birthDateController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => calendarPressed(
                          type: CalenderType.birthday,
                          initialDate: DateTime(2000),
                          startDate: DateTime(1901),
                          endDate: DateTime.now(),
                          mode: DatePickerMode.year,
                          description:
                              LocaleKeys.birth_date_picker_description.tr(),
                        ),
                        color: accentColor,
                        iconSize: 32,
                        icon: Icon(Icons.calendar_today_rounded),
                      ),
                      hintText: LocaleKeys.birth_date_hint.tr(),
                      hintStyle: hintTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.email.tr(),
                    style: contrastTextStyle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: updateConfessor?.email,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        InputSettings.validator.emailValidator(value),
                    onSaved: (value) {
                      value = value!.trim();
                      _email = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: LocaleKeys.email_address_hint.tr(),
                      hintStyle: hintTextStyle,
                    ),
                  ),
                  if (screenMode == ScreenMode.add)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          LocaleKeys.note.tr(),
                          style: contrastTextStyle,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          onSaved: (value) {
                            value = value!.trim();
                            _note =
                                value != "" ? value : LocaleKeys.no_notes.tr();
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: LocaleKeys.note_optional_hint.tr(),
                            hintStyle: hintTextStyle,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          LocaleKeys.confession_date.tr(),
                          style: contrastTextStyle,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _confessionDateController,
                          //onSaved: ,
                          readOnly: true,
                          decoration: InputDecoration(
                            //labelText: "Confession Date",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => calendarPressed(
                                type: CalenderType.confessionDate,
                                initialDate: DateTime.now(),
                                startDate: DateTime(DateTime.now().year - 10),
                                endDate: DateTime(DateTime.now().year + 1),
                                mode: DatePickerMode.day,
                                description: LocaleKeys
                                    .confession_date_picker_description
                                    .tr(),
                              ),
                              color: accentColor,
                              iconSize: 32,
                              icon: Icon(Icons.calendar_today_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(LocaleKeys.photo_library.tr()),
                      onTap: () {
                        readImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(LocaleKeys.camera.tr()),
                    onTap: () {
                      readImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
