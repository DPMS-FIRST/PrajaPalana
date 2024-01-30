import 'package:flutter/material.dart';
import 'package:praja_palana/models/applicationStatus/applicationSearchStatusPayload.dart';
import 'package:praja_palana/models/applicationStatus/applicationSearchStatusResponse.dart';
import 'package:praja_palana/repository/aplicant_details_repository.dart';
import 'package:praja_palana/repository/applicationStatusSearchRepository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/api_error_codes.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/view_model/validate_mpin_view_model.dart';
import 'package:provider/provider.dart';
import '../../models/applicant_details/applicant_schemewise_details_response.dart';
import '../../models/applicant_details/applicant_schemewise_payload.dart';

class ApplicationStatusViewModel extends ChangeNotifier {
  ApplicationStatusDetails? applicationStatusDetails;
  PersonalDtlsMdl? personalDtlsMdl;
  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  bool validateFields(context, String? searchValue) {
    if (searchValue == null || searchValue == '') {
      ValidationIoSAlert()
          .showAlert(context, description: "Please enter a application number");
      return false;
    }
    return true;
  }

  getApplicationSearchViewModel(context, String? applicationNumber) async {
    applicationStatusSearchPayLoad payload =
        applicationStatusSearchPayLoad(onlinEAPPLICATIONNO: applicationNumber);
    final response = await ApplicationStatusSearchRepository()
        .getApplicationStatusSearchRepository(context, payload);
    if (response != null) {
      applicationStatusDetails = null;
      setIsLoadingStatus(false);
      if (response.statusCode == ApiErrorCodes.SUCCESS) {
        if (response.applicationStatusDetails != null) {
          applicationStatusDetails = response.applicationStatusDetails;
          print("response----------> ${response.toJson()}");
        }
        notifyListeners();
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
    }
  }

  getApplicationDetails(BuildContext context, String applicationNo) async {
    if (await InternetCheck()) {
      final loginResponseProvider =
          Provider.of<ValidateMpinViewModel>(context, listen: false);
      final loginDetailsResponse = loginResponseProvider.getLoginDetails;
      setIsLoadingStatus(true);
      /* final payload = GetApplicantDetailsPayload(
        iTOKENID: "123",
        userid: "1382",
        onlinEAPPLICATIONNO: applicationNo,
      ); */
      final payload = ApplicationSchemewisePayload(
        iTOKENID: "123",
        userid: "1382",
        distid: int.parse(loginDetailsResponse?.data?.districtid ?? ""),
        idd: 485
      );
      print("userid=${loginDetailsResponse?.data?.userid}");

      final response = await ApplicantDetailsRepository()
          .getApplicationSchemeRepository(context, payload);

      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          print("response----------> ${response.toJson()}");
          if (response.data?.personalDtlsMdl != null) {
            personalDtlsMdl = response.data?.personalDtlsMdl;
          }
          if (response.data?.familyListMdl != null) {
            response.data?.familyListMdl;
          }
          if (response.data?.mahalakshmiMdl != null) {
            response.data?.mahalakshmiMdl;
          }
          if (response.data?.raithubharosaMdl != null) {
            response.data?.raithubharosaMdl;
          }
          if (response.data?.indirammaIndluMdl != null) {
            response.data?.indirammaIndluMdl;
          }
          if (response.data?.gruhajyothiMdl != null) {
            response.data?.gruhajyothiMdl;
          }
          if (response.data?.cheyuthaMdl != null) {
            response.data?.cheyuthaMdl;
          }

          setIsLoadingStatus(false);
          Navigator.pushNamed(context, AppRoutes.applicationstatusdetails);
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
      }
    } else {
      InternetCheckAlert().showAlert(context);
    }
  }
}
