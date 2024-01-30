import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/login/validate_login_details_payload.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/constants/api_constants.dart';
import 'package:flutter/widgets.dart';

class LoginRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
  Future<ValidLoginDetailsResponse> getOfficerLoginRepository(
      BuildContext context, ValidLoginDetailsPayload payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.ValidLoginDetails,
      payload.toJson(),
    );
    return ValidLoginDetailsResponse.fromJson(response);
  }
}
