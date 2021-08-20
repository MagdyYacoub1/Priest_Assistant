import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/localization/localization_constants.dart';
import 'package:priest_assistant/localization/my_localization.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  static const routeName = "/addPage_page";

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final avatarRadius = 80.0;
  DateTime datePicked;
  TextEditingController _dateController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Uint8List _image;
  String _fName;
  String _lName;
  String _address;
  String _phoneNumber;
  String _countryCode;
  String _email;
  String _notes;

  @override
  void initState() {
    super.initState();

    datePicked = new DateTime.now();
    String dateString = DateFormat.yMMMEd().format(datePicked);
    _dateController.text = dateString;
  }

  bool isValidPhone(String phone) {
    final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return phoneRegExp.hasMatch(phone);
  }

  void imageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    XFile photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    final path = photo.path;
    final bytes = File(path).readAsBytesSync();
    setState(() {
      _image = bytes;
    });
  }

  void imageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    final path = photo.path;
    final bytes = File(path).readAsBytesSync();
    setState(() {
      _image = bytes;
    });
  }

  void saveForm(BuildContext context) {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      if (_phoneNumber[0] == '0') {
        _phoneNumber = _phoneNumber.substring(1);
      }
      Confessor newConfessor = new Confessor(
          photo: _image,
          fName: _fName,
          lName: _lName,
          address: _address,
          email: _email,
          phone: _countryCode + _phoneNumber,
          notes: _notes,
          lastConfessDate: datePicked);

      Provider.of<ConfessorUtilities>(context, listen: false)
          .addConfessor(newConfessor);
      print(newConfessor.toString());
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
    final _locale = Provider.of<MyLocalization>(context).locale;
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(
                          Icons.arrow_back,
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
                          "Save",
                          style: ButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: (_locale.languageCode == Arabic)
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
                                  _image,
                                  scale: 2.0,
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
                    "Full name",
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter the first name";
                            else
                              return null;
                          },
                          onSaved: (value) {
                            value.trim();
                            _fName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "First name",
                            hintStyle: contextTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter the second name";
                            else
                              return null;
                          },
                          onSaved: (value) {
                            value.trim();
                            _lName = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Last name",
                            hintStyle: contextTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Address",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    onSaved: (value) {
                      value.trim();
                      _address = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Full address (Optional)",
                      hintStyle: contextTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Phone",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (phone) {
                      if (phone.isEmpty)
                        return "Please enter the phone number";
                      else if (!isValidPhone(phone))
                        return "Please enter a valid phone number";
                      else
                        return null;
                    },
                    onSaved: (value) {
                      value.trim();
                      _phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: CountryCodePicker(
                        initialSelection: _locale.countryCode,
                        favorite: ["EG", "US"],
                        onInit: (value) {
                          _countryCode =
                              _locale.countryCode == 'US' ? "+1" : "+20";
                        },
                        onChanged: (countryCode) {
                          _countryCode = countryCode.dialCode;
                          print(_countryCode);
                        },
                      ),
                      hintText: "Phone number",
                      hintStyle: contextTextStyle,
                    ),
                    //
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!value.isEmpty && !EmailValidator.validate(value))
                        return "Please enter a valid email";
                      else
                        return null;
                    },
                    onSaved: (value) {
                      value.trim();
                      _email = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Email address (Optional)",
                      hintStyle: contextTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Note",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    onSaved: (value) {
                      value.trim();
                      _notes = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Notes (Optional)",
                      hintStyle: contextTextStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Confession Date",
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
                              DateFormat.yMMMEd().format(datePicked);
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
                      title: new Text('Photo Library'),
                      onTap: () {
                        imageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imageFromCamera();
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
