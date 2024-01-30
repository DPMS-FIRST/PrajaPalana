import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/custom_success_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/utils/get_device_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/generate_mpin_payload.dart';
import '../models/generate_mpin_response.dart';
import '../repository/generate_mpin_repository.dart';
import '../routes/app_routes.dart';
import '../utils/api_error_codes.dart';
import '../utils/internet.dart';

class SetMpinViewModel with ChangeNotifier {
  bool isLoading = false;
  bool getIsLoadingStatus() => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  generateMPIN(
      BuildContext context,
      ValidLoginDetailsResponse? loginDetailsResponse,
      String mpin,
      String confirmMpin) async {
    print("mpin ::::::::${loginDetailsResponse?.data?.iMOBILENO}");
    print("confirmMpin::::::::::: ${loginDetailsResponse?.data?.userid}");

    if (mpin.isEmpty || mpin.length < 4) {
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: AppStrings.enter_4digit_mpin,
        onPressed: () async {
          Navigator.of(context).pop();
        },
      );
    } else if (confirmMpin.isEmpty || confirmMpin.length < 4) {
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: AppStrings.confirm_4digit_mpin,
        onPressed: () async {
          Navigator.of(context).pop();
        },
      );
    } else if (mpin != confirmMpin) {
      ErrorCustomCupertinoAlert().showAlert(
        context,
        message: AppStrings.mpin_unmatched,
        onPressed: () async {
          Navigator.of(context).pop();
        },
      );
    } else if (mpin == confirmMpin) {
      GenerateMPINPayLoad setMPINPayLoad = GenerateMPINPayLoad();
      setMPINPayLoad.userid = loginDetailsResponse?.data?.userid;
      setMPINPayLoad.mobileNumber = loginDetailsResponse?.data?.iMOBILENO;
      setMPINPayLoad.iTOKENID = loginDetailsResponse?.data?.iTOKENID;
      ;
      setMPINPayLoad.iMPIN = confirmMpin;
      setMPINPayLoad.deviceId = await GetDeviceId().getDeviceId();

      mpinApiCall(setMPINPayLoad, context, confirmMpin);
    }
  }

  mpinApiCall(GenerateMPINPayLoad setMPINPayLoad, BuildContext context,
      String mpin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await InternetCheck()) {
      setIsLoadingStatus(true);

      GenerateMPINResponse? response = await GenerateMPINRepository()
          .GenerateMpinRepo(context, setMPINPayLoad);
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          await prefs.setString('MPIN', mpin);

          SuccessCustomCupertinoAlert().showAlert(
            context: context,
            title: response.statusMessage ?? "",
          );

          // await LocalStoreHelper().writeData(SharedPrefConstants.mpin, mpin);
          Navigator.pushReplacementNamed(context, AppRoutes.validateMpin);
          setIsLoadingStatus(false);
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          setIsLoadingStatus(false);
          ErrorCustomCupertinoAlert().showAlert(
            context,
            message: response.statusMessage ?? "",
            onPressed: () async {
              Navigator.pop(context);
            },
          );
        } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
          ErrorCustomCupertinoAlert().showAlert(context,
              message: response.statusMessage ?? '', onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
          ErrorCustomCupertinoAlert()
              .showAlert(context, message: response.statusMessage ?? '');
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
}
