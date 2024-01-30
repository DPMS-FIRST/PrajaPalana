import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/getAadharNumberValid_payload.dart';
import 'package:praja_palana/models/getAadharNumberValid_response.dart';
import 'package:praja_palana/models/getRationValid_payload.dart';
import 'package:praja_palana/models/getRationValid_response.dart';
import 'package:praja_palana/res/constants/api_constants.dart';

class ValidateAadhaarRationRepository {
  final _baseApiClinet = BaseApiClient();
  //Aadhaar
  Future<GetAadharNumberValidResponse> ValidateAadhaarRepo(
      context, GetAadharNumberValidPayload payload) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.getAadharNumberValid,
      payload.toJson(),
    );
    return GetAadharNumberValidResponse.fromJson(response);
  }

  //Ration
  Future<GetRationNumberValidResponse> ValidateRationRepo(
      context, GetRationNumberValidPayload payload) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.getRationNumberValid,
      payload.toJson(),
    );
    return GetRationNumberValidResponse.fromJson(response);
  }
}
