import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/final_submit/application_final_submit_payload.dart';
import 'package:praja_palana/models/final_submit/application_final_submit_response.dart';
import 'package:praja_palana/res/constants/api_constants.dart';

class ApplicationFinalSubmitRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
  Future<ApplicationFinalSubmitResponse?> getApplicationfinalSubmitRepo(
      BuildContext context, ApplicationFinalSubmitPayload payload) async {
    final printPayload = payload.toJson();
    final stringPayload = json.encode(printPayload);
    print('Final Submit Payload: $stringPayload');
    final response = await _baseClient.postCall(
      context,
      ApiConstants.finalSubmit,
      payload.toJson(),
    );
    return ApplicationFinalSubmitResponse.fromJson(response);
  }
}
