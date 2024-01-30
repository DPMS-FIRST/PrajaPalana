import 'package:flutter/material.dart';
import 'package:praja_palana/models/application_search/application_search_response.dart';
import 'package:praja_palana/models/application_search/application_ssearch_payload.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/repository/dashboard_list_repository.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/constants/app_constants.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/api_error_codes.dart';

class DashboardListViewModel with ChangeNotifier {
  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
  }

  final applicationListRepo = DashboardListRepository();

  List<ApplicationStatus>? applicationDetailsList;
  List<ApplicationStatus>? get getApplicationDetailsList =>
      applicationDetailsList;

  getApplicationListViewModel(
    BuildContext context,
    ValidLoginDetailsResponse? loginResponse,
  ) async {
    final payload = ApplicationSearchPayload(
      userid: loginResponse?.data?.userid,
      iTOKENID: loginResponse?.data?.iTOKENID,
      ptype: AppConstants.titleText,
      aadhaRNO: "",
      applicantName: "",
      applicantmobileNumber: "",
      distid: loginResponse?.data?.districtid,
      id: loginResponse?.data?.panchayatid,
      ratioNCARDNO: "",
    );

    final response = await applicationListRepo.getApplicationListRepository(
        context, payload);
    setIsLoadingStatus(false);
    if (response != null) {
      if (response.statusCode == ApiErrorCodes.SUCCESS) {
        applicationDetailsList = response.data?.applicationStatus;
        notifyListeners();
      } else if (response.statusCode == ApiErrorCodes.BAD_REQUEST) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response.statusMessage.toString(),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        );
      } else if (response.statusCode == ApiErrorCodes.SESSION_EXPIRED) {
        ErrorCustomCupertinoAlert().showAlert(
          context,
          message: response.statusMessage ?? "",
          onPressed: () async {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
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
}
