import 'dart:io';
import 'package:praja_palana/data/sharedpreferences/share_pref_constants.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:praja_palana/res/CustomAlerts/custom_warning_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/splash_payload.dart';
import '../repository/splash_repository.dart';
import '../res/constants/app_constants.dart';
import '../res/constants/app_strings.dart';
import '../routes/app_routes.dart';
import '../utils/api_error_codes.dart';

class SplashViewModel with ChangeNotifier {
  final _splashRepository = SplashRepository();
  String? mpin, mobileType;
  splashService(context) async {
    print("view model");
    if (Platform.isAndroid) {
      mobileType = AppStrings.mobileTypeAndroid;
    } else if (Platform.isIOS) {
    //  mobileType = AppStrings.mobileTypeios;
        mobileType = AppStrings.mobileTypeAndroid;
    }

    final versionCheckPayload =
        VersionCheckPayload(departmentName: "CGG", deviceType: mobileType);
    if (await InternetCheck()) {
      final response = await _splashRepository.versionCheckRepo(
          context, versionCheckPayload);
      print("resoonse ${response?.data?.versioNNO}");
      if (response?.statusCode == ApiErrorCodes.SUCCESS) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String Appversion = packageInfo.version;
        AppConstants.version_number = response?.data?.versioNNO.toString();
        double localVersion = double.tryParse(Appversion) ?? 0.0;
        String? serverVer = response?.data?.versioNNO.toString();
        double serverVersion = double.tryParse(serverVer ?? '') ?? 0.0;
        print("local version ${localVersion}, server version ${serverVersion}");

        await prefs.setString(SharedConstants.versionNumver, "${localVersion}");

        await prefs.setString(SharedConstants.lastUpdateDate,
            "${response?.data?.lastupdateDDATE}");
        mpin = await prefs.getString('MPIN');
        if (response?.data?.versioNNO != null &&
                localVersion == serverVersion ||
            localVersion > serverVersion) {
          if (mpin == null || mpin.toString() == "") {
            Navigator.pushNamed(
              context,
              AppRoutes.login,
            );
          } else {
            Navigator.pushNamed(
              context,
              AppRoutes.validateMpin,
            );
          }
        } else {
          WarningCustomCupertinoAlert().showAlert(context,
              message: AppConstants.server_not_responding, onPressed: () async {
            if (Platform.isIOS) {
              final packageInfo = await PackageInfo.fromPlatform();
              final packageName = packageInfo.packageName;

              final packageId = "market://details?id=$packageName";
              // final packageId1 = response?.data?.ioSURL;

              final url = Uri.parse("$packageId");
              print("packageName ${url}");
              launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
            } else if (Platform.isAndroid) {
              final packageId = response?.data?.androiDURL;
              final url = Uri.parse("$packageId");
              launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
            }
          });
        }
      } else if (response?.statusCode == ApiErrorCodes.BAD_REQUEST) {
        ErrorCustomCupertinoAlert()
            .showAlert(context, message: response?.statusMessage ?? '');
      } else {
        // EasyLoading.dismiss();
        ErrorCustomCupertinoAlert()
            .showAlert(context, message: response?.statusMessage ?? '');
      }
    } else {
      InternetCheckAlert().showAlert(context);
    }
  }
}
