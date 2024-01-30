import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/models/application_search/application_search_any_payload.dart';
import 'package:praja_palana/models/application_search/application_ssearch_payload.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/repository/application_search_repository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/CustomAlerts/validation_ios_alert.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/view_model/validate_mpin_view_model.dart';
import 'package:provider/provider.dart';
import '../models/application_search/application_search_response.dart';
import '../routes/app_routes.dart';
import '../utils/api_error_codes.dart';

class ApplicationSearchViewModel with ChangeNotifier {
  List<ApplicationStatus>? applicationDetailsList;
  List<ApplicationStatus>? get getApplicationDetailsList =>
      applicationDetailsList;
  validateAndNavigate(
      BuildContext context,
      TextEditingController applicantNoController,
      TextEditingController mobileNoController,
      TextEditingController aadhaarController,
      TextEditingController rationNocontroller) async {
    if (applicantNoController.text.isNotEmpty ||
        mobileNoController.text.isNotEmpty ||
        aadhaarController.text.isNotEmpty ||
        rationNocontroller.text.isNotEmpty) {
      /*  if (mobileNoController.text.isNotEmpty &&
          (mobileNoController.text.length < 10 ||
              !RegExp(r'^([6-9]{1})([0-9]{9})$')
                  .hasMatch(mobileNoController.text))) {
        ValidationIoSAlert().showAlert(context,
            description: "Please enter valid mobile number");
      } else if (aadhaarController.text.isNotEmpty &&
          (aadhaarController.text.length < 12 ||
              (VerhoeffAlgorithm.validateVerhoeff(aadhaarController.text) ==
                  false))) {
        ValidationIoSAlert().showAlert(context,
            description: "Please enter valid aadhaar number");
      } else if (rationNocontroller.text.isNotEmpty &&
          rationNocontroller.text.length < 10) {
        ValidationIoSAlert().showAlert(context,
            description: "Please enter a valid Ration Card number");
      } else { */
      applicationDetailsList = [];
      if (await InternetCheck()) {
        final loginResponseProvider =
            Provider.of<ValidateMpinViewModel>(context, listen: false);
        final loginDetailsResponse = loginResponseProvider.getLoginDetails;
        setIsLoadingStatus(true);
        ApplicationSearchPayload payload = ApplicationSearchPayload(
            iTOKENID: loginDetailsResponse?.data?.iTOKENID,
            userid: loginDetailsResponse?.data?.userid,
            distid: loginDetailsResponse?.data?.districtid ?? '',
            aadhaRNO: aadhaarController.text.toString().trim(),
            applicantmobileNumber: mobileNoController.text.toString().trim(),
            ratioNCARDNO: rationNocontroller.text.toString().trim(),
            onlinEAPPLICATIONNO: applicantNoController.text.toString().trim(),
            id: loginDetailsResponse?.data?.panchayatid ?? '',
            panMun: "");

        final response = await ApplicationSearchRepository()
            .getApplicationSearchRepository(context, payload);
        if (response != null) {
          setIsLoadingStatus(false);
          if (response.statusCode == ApiErrorCodes.SUCCESS) {
            if (response.data != null) {
              if (response.data?.applicationStatus?.length == 0) {
                ErrorCustomCupertinoAlert().showAlert(
                  context,
                  message: "No Record Found",
                  onPressed: () async {
                    applicantNoController.clear();
                    mobileNoController.clear();
                    aadhaarController.clear();
                    rationNocontroller.clear();
                    notifyListeners();
                    Navigator.pop(context);
                  },
                );
              } else {
                applicationDetailsList = response.data?.applicationStatus;
              }
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
      } else {
        InternetCheckAlert().showAlert(context);
      }
      // }
    } else {
      ValidationIoSAlert()
          .showAlert(context, description: "Please enter any one of the field");
    }
  }

  bool validateFields(context, String? searchValue) {
    if (searchValue == null || searchValue == '') {
      ValidationIoSAlert()
          .showAlert(context, description: "Please Enter Aadhaar Number");
      return false;
    }
    return true;
  }

  getApplicationSearchViewModel(
      context,
      ValidLoginDetailsResponse? loginResponse,
      TextEditingController? searchField) async {
    print("login response ${jsonEncode(loginResponse)}");
    /* ApplicationSearchPayload payload = ApplicationSearchPayload(
        iTOKENID: loginResponse?.data?.iTOKENID,
        applicantName: applicationNumber,
        applicantmobileNumber: "",
        aadhaRNO: "",
        ratioNCARDNO: "",
        userid: loginResponse?.data?.userid); */
         applicationDetailsList=[];
    ApplicationSearchAnyPayload payload = ApplicationSearchAnyPayload(
        iTOKENID: loginResponse?.data?.iTOKENID,
        userid: loginResponse?.data?.userid,
        distid: int.tryParse(loginResponse?.data?.districtid ?? ''),
        panchayatid: loginResponse?.data?.panchayatid,
        any: searchField?.text.toString().trim());
    final response = await ApplicationSearchRepository()
        .getApplicationSearchAnyRepository(context, payload);

    if (response != null) {
      setIsLoadingStatus(false);
      if (response.statusCode == ApiErrorCodes.SUCCESS) {
        if (response.data != null) {
          if (response.data!.applicationStatus!.length > 0) {
            applicationDetailsList = response.data?.applicationStatus;
          } else {
            ErrorCustomCupertinoAlert().showAlert(
              context,
              message: "No Record Found",
              onPressed: () async {
                searchField?.clear();
                notifyListeners();
                Navigator.pop(context);
              },
            );
          }
        }
        notifyListeners();
        setIsLoadingStatus(false);
      } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: "${response.statusMessage}",
          onPressed: () async {
            searchField?.clear();
            notifyListeners();
            Navigator.pop(context);
          },
        );
        setIsLoadingStatus(false);
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

  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }
}
