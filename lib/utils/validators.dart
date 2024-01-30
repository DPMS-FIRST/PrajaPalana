import 'package:praja_palana/utils/app_regex.dart';

class Validators {
  bool validateNumber(number) {
    return RegExp(AppRegex.mobileNumberPattern).hasMatch(number);
  }
}
