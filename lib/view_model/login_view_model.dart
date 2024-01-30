import 'dart:convert';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/models/login/validate_login_details_payload.dart';
import 'package:praja_palana/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/utils/api_error_codes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/CustomAlerts/validation_ios_alert.dart';
import '../routes/app_routes.dart';
import '../utils/get_device_address.dart';

class LoginViewModel with ChangeNotifier {
  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  bool validateUserName(BuildContext context, String mobileNumber) {
    if (mobileNumber.isEmpty) {
      ValidationIoSAlert().showAlert(
        context,
        description: AppStrings.enterValidmobileNumber,
      );
      return false;
    } else if (mobileNumber.length < 10) {
      ValidationIoSAlert().showAlert(
        context,
        description: AppStrings.enter10DigitmobileNumber,
      );
      return false;
    } else if (!RegExp(r'^([6-9]{1})([0-9]{9})$').hasMatch(mobileNumber)) {
      ValidationIoSAlert().showAlert(
        context,
        description: AppStrings.enterValidmobileNumber,
      );
      return false;
    }
    return true;
  }

  final loginRepository = LoginRepository();

  ValidLoginDetailsResponse? loginResponse;
  ValidLoginDetailsResponse? get getValidateLoginResponse => loginResponse;

  getOfficerLoginViewModel(BuildContext context, String mobile) async {
    final deviceId = await GetDeviceId().getDeviceId();
    final payload =
        ValidLoginDetailsPayload(mobileNumber: mobile, deviceId: deviceId);
    final response =
        await loginRepository.getOfficerLoginRepository(context, payload);
    setIsLoadingStatus(false);
    if (response.statusCode == ApiErrorCodes.SUCCESS) {
      loginResponse = response;
      AppConstants.userName = loginResponse?.data?.vCEMPNAME ?? '';
      print("username ----- ${AppConstants.userName}");
      //shared preference
      String loginResponseJson = json.encode(loginResponse);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ValidateLoginResponse', loginResponseJson);

      if (loginResponse?.data?.iOTP != null &&
          (loginResponse?.data?.iMPIN == "" ||
              loginResponse?.data?.iMPIN == null)) {
        print("Otp :::: ${loginResponse?.data?.iOTP}");
        prefs.setInt('OTP', loginResponse?.data?.iOTP ?? 0);
        Navigator.pushNamed(context, AppRoutes.otp);
        
      } else if (loginResponse?.data?.iMPIN != null &&
          (loginResponse?.data?.iOTP == "" ||
              loginResponse?.data?.iOTP == null)) {
        print("mpin :::: ${loginResponse?.data?.iMPIN}");
        String mpinvalue = "${loginResponse?.data?.iMPIN}";
        prefs.setString('MPIN', mpinvalue.trim());

        Navigator.pushNamed(context, AppRoutes.validateMpin);
      }
    } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: response.statusMessage.toString(),
        onPressed: () async {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
      );
    } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: response.message.toString(),
        onPressed: () async {
          Navigator.pop(context);
        },
      );
    } else {
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: response.statusMessage.toString(),
        onPressed: () async {
          Navigator.pop(context);
        },
      );
    }
  }

  ValidLoginDetailsResponse? loginDetails;
  ValidLoginDetailsResponse? get getLoginDetails => loginDetails;
  getLoginResponseDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginResponse = await prefs.getString('ValidateLoginResponse') ?? '';

    if (loginResponse.isEmpty || loginResponse == "") {
      loginDetails = ValidLoginDetailsResponse();
    } else {
      Map<String, dynamic> jsonData = json.decode(loginResponse);
      loginDetails = ValidLoginDetailsResponse.fromJson(jsonData);
    }
  }
}
