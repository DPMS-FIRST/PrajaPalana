import 'package:flutter/material.dart';
import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/application_search/application_search_response.dart';
import 'package:praja_palana/models/application_search/application_ssearch_payload.dart';
import 'package:praja_palana/res/constants/api_constants.dart';

class DashboardListRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
  Future<ApplicationSearchResponse?> getApplicationListRepository(
      BuildContext context, ApplicationSearchPayload payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.getApplicationSearch,
      payload.toJson(),
    );
    return ApplicationSearchResponse.fromJson(response);
  }
}
