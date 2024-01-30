import 'package:flutter/material.dart';
import 'package:praja_palana/models/dashboard_report/dashboard_report_payload.dart';
import 'package:praja_palana/models/dashboard_report/dashboard_report_response.dart';

import '../models/login/validate_login_details_response.dart';
import '../repository/dashboard_report_repository.dart';
import '../res/CustomAlerts/custom_error_alert.dart';
import '../res/CustomAlerts/internet_check_alert.dart';
import '../routes/app_routes.dart';
import '../utils/api_error_codes.dart';
import '../utils/internet.dart';

class DashboardReportsViewModel with ChangeNotifier {
  bool isLoading = false;
  bool get getIsLoadingStatus => isLoading;
  setIsLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  List<ReportsData>? dashboardData = [];
  List<ReportsData>? get getDashboardReportsData => dashboardData;
  dashboardReportsApiCall(BuildContext context,
      ValidLoginDetailsResponse? loginDetailsResponse) async {
    if (await InternetCheck()) {
      setIsLoadingStatus(true);
      DashboardReportPayload reportsPaylod = DashboardReportPayload();
      print("userid=${loginDetailsResponse?.data?.userid}");
      reportsPaylod.userid = loginDetailsResponse?.data?.userid;
      reportsPaylod.iTOKENID = loginDetailsResponse?.data?.iTOKENID;
      reportsPaylod.distid = int.tryParse(
          loginDetailsResponse?.data?.districtid.toString() ?? '0');
      reportsPaylod.paNMUNID = loginDetailsResponse?.data?.panchayatid ?? '0';

      DashboardReportResponse? response = await DashboardReportRepository()
          .getDashboardReportsRepository(context, reportsPaylod);
      if (response != null) {
        setIsLoadingStatus(false);
        if (response.statusCode == ApiErrorCodes.SUCCESS) {
          if (response.data != null) {
            dashboardData = response.data;
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
      } else {
        InternetCheckAlert().showAlert(context);
      }
    }
  }
}
