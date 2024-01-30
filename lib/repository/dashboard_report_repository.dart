import 'package:flutter/material.dart';
import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/dashboard_report/dashboard_report_payload.dart';
import 'package:praja_palana/models/dashboard_report/dashboard_report_response.dart';
import 'package:praja_palana/res/constants/api_constants.dart';

class DashboardReportRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
  Future<DashboardReportResponse?> getDashboardReportsRepository(
      BuildContext context, DashboardReportPayload payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.dashboardReport,
      payload.toJson(),
    );
    return DashboardReportResponse.fromJson(response);
  }
}
