import 'package:flutter/cupertino.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/utils/get_device_address.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login/resend_otp_payload.dart';
import '../repository/resend_otp_repository.dart';
import '../utils/api_error_codes.dart';

class OtpViewModel with ChangeNotifier {
  final _resendRepo = ResendOTPRepository();
  int? resendOtp;
  int? get getResendOtp => resendOtp;
  getResendOtpVM(
    BuildContext context,
    ValidLoginDetailsResponse? loginResponse,
  ) async {
    setIsLoadingStatus(true);
    final payload = ResendOtpPayload(
        mobileNumber: loginResponse?.data?.iMOBILENO,
        deviceId: await GetDeviceId().getDeviceId(),
        userid: loginResponse?.data?.userid,
        iTOKENID: loginResponse?.data?.iTOKENID);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _resendRepo.getResendOTPRepo(context, payload);
    setIsLoadingStatus(false);
    if (response != null) {
      if (response.statusCode == ApiErrorCodes.SUCCESS) {
        resendOtp = response.data?.iOTP;
        await prefs.setInt('OTP', resendOtp ?? 0);
      } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response.statusMessage.toString(),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        );
      } else {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response.statusMessage ?? "",
          onPressed: () async {
            Navigator.of(context).pop();
          },
        );
      }
    } else {
      setIsLoadingStatus(false);
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: "${AppStrings.something_went_wrong}",
        onPressed: () async {
          Navigator.of(context).pop();
        },
      );
    }
  }

  bool _isLoading = false;
  bool get getIsLoadingStatus => _isLoading;
  setIsLoadingStatus(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool otpValidateFields(
    BuildContext context,
    String otp,
    int? mobileOtp,
  ) {
    if (otp.isEmpty) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter OTP",
      );
      return false;
    } else if (otp.length < 4) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Please enter valid OTP",
      );
      return false;
    } else if (otp != mobileOtp.toString()) {
      ValidationIoSAlert().showAlert(
        context,
        description: "Incorrect OTP",
      );
      return false;
    }
    return true;
  }
}
