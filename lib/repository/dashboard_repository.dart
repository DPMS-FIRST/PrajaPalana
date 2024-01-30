import 'package:flutter/material.dart';
import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/dashboard_abstract/dashboard_abstract_request.dart';
import 'package:praja_palana/models/dashboard_abstract/dashboard_abstract_response.dart';
import 'package:praja_palana/res/constants/api_constants.dart';

class DashboardRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
  Future<DashboardAbstractResponse?> getDashboardAbstractRepository(
      BuildContext context, DashboardAbstractRequest payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.DashboardAbstract,
      payload.toJson(),
    );
    return DashboardAbstractResponse.fromJson(response);
  }
}
