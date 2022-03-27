import 'dart:io';
import 'dart:typed_data';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/widgets/snackBar_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/screens/profile_screen/profile_page.dart';
import 'package:priest_assistant/translations/localization_constants.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../styling.dart';

class EditPage extends StatefulWidget {
  static const routeName = "/editPage_page";
  final dynamic confessorKey;

  const EditPage({Key? key, this.confessorKey}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final avatarRadius = 80.0;
  final _formKey = GlobalKey<FormState>();
  Confessor? confessor;
  Uint8List? _image;
  String? _fName;
  String? _lName;
  String? _address;
  String? _phoneNumber;
  String? _countryCode;
  String? _email;

  @override
  void initState() {
    confessor = ConfessorUtilities.readConfessor(widget.confessorKey);
    _image = confessor!.photo;
    _fName = confessor!.fName;
    _lName = confessor!.lName;
    _address = confessor!.address;
    _phoneNumber = confessor!.phone;
    _countryCode = confessor!.countryCode;
    _email = confessor!.email;

    super.initState();
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
      Confessor updatedConfessor = confessor!;
      updatedConfessor.photo = _image;
      updatedConfessor.fName = _fName!;
      updatedConfessor.lName = _lName!;
      updatedConfessor.address = _address;
      updatedConfessor.email = _email;
      updatedConfessor.phone = _phoneNumber!;
      updatedConfessor.countryCode = _countryCode!;

      ConfessorUtilities.editConfessor(updatedConfessor);
      showSnackBar(context, LocaleKeys.confessor_updated.tr());
      Navigator.of(context).popAndPushNamed(ProfilePage.routeName,
          arguments: updatedConfessor.key);
    }
  }

  void _onBackPressed() {
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
                      arguments: confessor!.key);
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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarPadding = 4.0 + mediaQuery.padding.top;
    return Scaffold(
      backgroundColor: mainColor,
      body: WillPopScope(
        onWillPop: () async => false,
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
                        ? Offset((-mediaQuery.size.width / 2) + avatarRadius,
                            (mediaQuery.size.height * 0.12) - avatarRadius)
                        : Offset((mediaQuery.size.width / 2) - avatarRadius,
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
                          initialValue: _fName,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty)
                              return LocaleKeys.first_name_error_msg.tr();
                            else
                              return null;
                          },
                          onSaved: (value) {
                            value!.trim();
                            _fName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: LocaleKeys.first_name.tr(),
                            hintStyle: contextTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          initialValue: _lName,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty)
                              return LocaleKeys.second_name_error_msg.tr();
                            else
                              return null;
                          },
                          onSaved: (value) {
                            value!.trim();
                            _lName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: LocaleKeys.last_name.tr(),
                            hintStyle: contextTextStyle,
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
                    initialValue: _address,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    onSaved: (value) {
                      value!.trim();
                      _address = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: LocaleKeys.full_address_hint.tr(),
                      hintStyle: contextTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.phone.tr(),
                    style: contrastTextStyle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _phoneNumber,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (phone) {
                      if (phone!.isEmpty)
                        return LocaleKeys.phone_number_error_msg.tr();
                      else if (!isValidPhone(phone))
                        return LocaleKeys.valid_phone_error_msg.tr();
                      else
                        return null;
                    },
                    onSaved: (value) {
                      value!.trim();
                      _phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: CountryCodePicker(
                        initialSelection: _countryCode,
                        favorite: ["EG", "US"],
                        onChanged: (countryCode) {
                          _countryCode = countryCode.dialCode;
                          //print(_countryCode);
                        },
                      ),
                      hintText: LocaleKeys.phone_number.tr(),
                      hintStyle: contextTextStyle,
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
                    initialValue: _email,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isNotEmpty && !EmailValidator.validate(value))
                        return LocaleKeys.valid_email_error_msg.tr();
                      else
                        return null;
                    },
                    onSaved: (value) {
                      value!.trim();
                      _email = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: LocaleKeys.email_address_hint.tr(),
                      hintStyle: contextTextStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
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
      },
    );
  }
}
