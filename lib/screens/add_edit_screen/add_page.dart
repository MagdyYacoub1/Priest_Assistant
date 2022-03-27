import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:priest_assistant/styling.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/widgets/snackBar_widget.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/entities/note.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:priest_assistant/translations/localization_constants.dart';

class AddPage extends StatefulWidget {
  static const routeName = "/addPage_page";

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final avatarRadius = 80.0;
  DateTime? datePicked;
  bool initialBuild = true;
  TextEditingController _dateController = new TextEditingController();
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
    datePicked = new DateTime.now();
    String dateString =
        DateFormat.yMMMEd(context.locale.toString()).format(datePicked!);
    _dateController.text = dateString;
    initialBuild = false;
  }

  bool isValidPhone(String phone) {
    final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return phoneRegExp.hasMatch(phone);
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

      Confessor newConfessor = new Confessor(
          photo: _image,
          fName: _fName!,
          lName: _lName!,
          address: _address,
          email: _email,
          phone: _phoneNumber!,
          countryCode: _countryCode!,
          notes: [Note(content: _note, date: datePicked!)],
          lastConfessDate: datePicked!);

      ConfessorUtilities.addConfessor(newConfessor);
      showSnackBar(context, LocaleKeys.confessor_added_msg.tr());
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarPadding = 4.0 + mediaQuery.padding.top;
    if (initialBuild) initDateField(context);
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        )),
                        backgroundColor: MaterialStateProperty.all(accentColor),
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
                      ? Offset((-mediaQuery.size.width / 2) + avatarRadius + 20,
                          (mediaQuery.size.height * 0.12) - avatarRadius)
                      : Offset((mediaQuery.size.width / 2) - avatarRadius - 20,
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
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          value = value!.trim();
                          if (value.isEmpty)
                            return LocaleKeys.first_name_error_msg.tr();
                          else
                            return null;
                        },
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
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          value = value!.trim();
                          if (value.isEmpty)
                            return LocaleKeys.second_name_error_msg.tr();
                          else
                            return null;
                        },
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
                  LocaleKeys.email.tr(),
                  style: contrastTextStyle,
                ),
                SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    value = value!.trim();
                    if (value.isNotEmpty && !EmailValidator.validate(value))
                      return LocaleKeys.email_error_msg.tr();
                    else
                      return null;
                  },
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
                    _note = value != "" ? value : LocaleKeys.no_notes.tr();
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
                  controller: _dateController,
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
                      onPressed: () async {
                        datePicked = await showRoundedDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 10),
                          lastDate: DateTime(DateTime.now().year + 10),
                          borderRadius: 16,
                        );
                        datePicked =
                            datePicked == null ? DateTime.now() : datePicked;
                        String dateString =
                            DateFormat.yMMMEd(context.locale.toString())
                                .format(datePicked!);
                        _dateController.text = dateString;
                      },
                      color: accentColor,
                      iconSize: 32,
                      icon: Icon(Icons.calendar_today_rounded),
                    ),
                  ),
                ),
              ],
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
