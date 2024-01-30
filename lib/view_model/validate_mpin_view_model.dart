import 'dart:convert';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/models/validate_mpin_payload.dart';
import 'package:praja_palana/models/validate_mpin_response.dart';
import 'package:praja_palana/repository/generate_mpin_repository.dart';
import 'package:praja_palana/repository/validate_mpin_repository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/utils/get_device_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/local_store_helper.dart';
import '../models/generate_mpin_payload.dart';
import '../models/generate_mpin_response.dart';
import '../res/constants/app_constants.dart';
import '../routes/app_routes.dart';
import '../utils/api_error_codes.dart';
import '../utils/internet.dart';
import '../utils/shared_pref_constants.dart';

class ValidateMpinViewModel with ChangeNotifier {
  bool isLoading = false;
  bool getIsLoadingStatus() => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
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
      AppConstants.userName = loginDetails?.data?.vCEMPNAME ?? '';
    }
  }

  validateMpin(String mpin, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final SavedMPIN = await prefs.getString("MPIN");

    //Code for checking mpins match or not
    print("saved mpin:::${SavedMPIN}   entered mpin ${mpin}");
    if (mpin.isEmpty || mpin.length < 4) {
      setIsLoadingStatus(false);
      ValidationIoSAlert().showAlert(
        context,
        description: AppStrings.enter_4digit_mpin,
      );
    } else {
      await getLoginResponseDetails();
      validateMpinApiCall(context, mpin, loginDetails);
    }
    // } else if (mpin != SavedMPIN.toString()) {
    //   setIsLoadingStatus(false);
    //   ValidationIoSAlert().showAlert(
    //     context,
    //     description: AppStrings.valid_mpin,
    //   );
    // } else if (mpin == SavedMPIN.toString()) {
    //   await getLoginResponseDetails();
    // //  setIsLoadingStatus(false);
    //  // Navigator.pushNamed(context, AppRoutes.dashboard);
    // }
  }

  LoginToAnotherAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  notYOU(BuildContext context) async {
    Navigator.pushNamed(context, AppRoutes.login);
    await LocalStoreHelper().clearData();
    final value =
        await LocalStoreHelper().containsKey(SharedPrefConstants.mpin);
    print("hello::::${value}");
  }

  forgotMPIN(BuildContext context,
      ValidLoginDetailsResponse? loginDetailsResponse) async {
    print("forgotmpin ::::::::${loginDetailsResponse?.data?.iMOBILENO}");
    print("forgotconfirmMpin::::::::::: ${loginDetailsResponse?.data?.userid}");
    GenerateMPINPayLoad setMPINPayLoad = GenerateMPINPayLoad();
    setMPINPayLoad.userid = loginDetailsResponse?.data?.userid;
    setMPINPayLoad.iTOKENID = loginDetailsResponse?.data?.iTOKENID;
    ;
    setMPINPayLoad.mobileNumber = loginDetailsResponse?.data?.iMOBILENO;
    setMPINPayLoad.iMPIN = "";
    setMPINPayLoad.deviceId = await GetDeviceId().getDeviceId();

    if (await InternetCheck()) {
      setIsLoadingStatus(true);

      GenerateMPINResponse? response = await GenerateMPINRepository()
          .GenerateMpinRepo(context, setMPINPayLoad);
      setIsLoadingStatus(false);
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          setIsLoadingStatus(false);
        } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
          ErrorCustomCupertinoAlert().showAlert(context,
              message: response.statusMessage ?? '', onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.message ?? '');
        } else {
          // EasyLoading.dismiss();
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
        }
      } else {
        InternetCheckAlert().showAlert(context);
      }
    }
  }

  validateMpinApiCall(BuildContext context, String enteredMpin,
      ValidLoginDetailsResponse? loginDetailsResponse) async {
    print("validatempin ::::::::${loginDetailsResponse?.data?.iMOBILENO}");
    print("validateMpin::::::::::: ${loginDetailsResponse?.data?.userid}");
    ValidateMpinPayload validateMpinPayload = ValidateMpinPayload();
    validateMpinPayload.userid = loginDetailsResponse?.data?.userid;
    validateMpinPayload.tokenid = loginDetailsResponse?.data?.iTOKENID;
    ;

    validateMpinPayload.mpin = enteredMpin;

    if (await InternetCheck()) {
      setIsLoadingStatus(true);

      ValidateMPINResponse? response = await ValidateMPINRepository()
          .ValidateMpinRepo(context, validateMpinPayload);
      setIsLoadingStatus(false);
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          setIsLoadingStatus(false);
        } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
          ErrorCustomCupertinoAlert().showAlert(context,
              message: response.message ?? '', onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.message ?? '');
        } else {
          // EasyLoading.dismiss();
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.message ?? '');
        }
      } else {
        InternetCheckAlert().showAlert(context);
      }
    }
  }
}
