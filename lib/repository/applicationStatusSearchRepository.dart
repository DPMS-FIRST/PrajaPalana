import 'package:flutter/material.dart';
import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/applicationStatus/applicationSearchStatusPayload.dart';
import 'package:praja_palana/models/applicationStatus/applicationSearchStatusResponse.dart';
import 'package:praja_palana/res/constants/api_constants.dart';


class ApplicationStatusSearchRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
  Future<applicationStatusSearchResponse?> getApplicationStatusSearchRepository(
      BuildContext context, applicationStatusSearchPayLoad payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.applicationStatus,
      payload.toJson(),
    );
    return applicationStatusSearchResponse.fromJson(response);
  }
}
