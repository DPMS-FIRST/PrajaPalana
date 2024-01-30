import 'package:flutter/material.dart';
import '../res/CustomAlerts/validation_ios_alert.dart';
import '../routes/app_routes.dart';
import '../utils/internet.dart';

class LoginWithMobileViewModel with ChangeNotifier {
  UserLogin(dynamic mobile, dynamic password, BuildContext context) async {
    if (validateInputs(mobile, context)) {
      if (checkPassword(password, context)) {
        final connection = await InternetCheck();
        if (connection) {
          Navigator.pushNamed(context, AppRoutes.validateMpin);
        }
      }
    }
  }

  validateInputs(mobile, context) {
    if (mobile.isEmpty) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Mobile Number and try again",
      );
      return false;
    } else if (mobile.length < 10) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter Valid Mobile Number",
      );
      return false;
    } else {
      return true;
    }
  }

  checkPassword(password, context) {
    if (password.isEmpty || password == null || password == "") {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please Enter password and try again",
      );
      return false;
    } else {
      return true;
    }
  }
}
