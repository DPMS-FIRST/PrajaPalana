import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/validate_mpin_payload.dart';
import 'package:praja_palana/models/validate_mpin_response.dart';
import 'package:praja_palana/res/constants/api_constants.dart';

class ValidateMPINRepository {
  final _baseApiClinet = BaseApiClient();
  Future<ValidateMPINResponse?> ValidateMpinRepo(
      context, ValidateMpinPayload generateMpinPayLoad) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.validateMpin,
      generateMpinPayLoad.toJson(),
    );
    return ValidateMPINResponse.fromJson(response);
  }
}