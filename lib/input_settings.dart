import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';

class InputSettings {
  static Validator validator = Validator();
}

class Validator {
  String? firstNameValidator(String? value) {
    value = value!.trim();
    if (value.isEmpty)
      return LocaleKeys.first_name_error_msg.tr();
    else
      return null;
  }

  String? secondNameValidator(String? value) {
    value = value!.trim();
    if (value.isEmpty)
      return LocaleKeys.second_name_error_msg.tr();
    else
      return null;
  }

  String? emailValidator(String? value) {
    value = value!.trim();
    if (value.isNotEmpty && !EmailValidator.validate(value))
      return LocaleKeys.email_error_msg.tr();
    else
      return null;
  }
}
