import '../data/base_api_client.dart';
import '../models/splash_payload.dart';
import '../models/splash_response.dart';
import '../res/constants/api_constants.dart';

class SplashRepository {
  final _baseApiClinet = BaseApiClient();
  Future<VersionCheckResponse?> versionCheckRepo(
      context, VersionCheckPayload versionCheckPayload) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.VERSION_CHECK,
      versionCheckPayload.toJson(),
    );
    return VersionCheckResponse.fromJson(response);
  }
}
