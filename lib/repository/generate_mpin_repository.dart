

import '../data/base_api_client.dart';
import '../models/generate_mpin_payload.dart';
import '../models/generate_mpin_response.dart';
import '../res/constants/api_constants.dart';

class GenerateMPINRepository {
  final _baseApiClinet = BaseApiClient();
  Future<GenerateMPINResponse?> GenerateMpinRepo(
      context, GenerateMPINPayLoad generateMpinPayLoad) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.generateMpin,
      generateMpinPayLoad.toJson(),
    );
    return GenerateMPINResponse.fromJson(response);
  }
}
