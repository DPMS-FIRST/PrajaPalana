import 'package:praja_palana/models/ps_masters_payload.dart';
import 'package:praja_palana/models/ps_masters_response.dart';
import '../data/base_api_client.dart';
import '../res/constants/api_constants.dart';

class IndirammaMastersRepository {
  final _baseApiClinet = BaseApiClient();
/*   Future<GeographicsMastersResponse?> downloadIndirammaMastersRepo(
      context) async {
    final response = await _baseApiClinet.getCall(
      context,
      ApiConstants.getGeoGrapicMaters,
    );
    return GeographicsMastersResponse.fromJson(response);
  } */

  Future<PSMastersResponse?> downloadPSMastersRepo(
      context, PSPayload psPayload) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.getPoliceStationMasters,
      psPayload.toJson(),
    );
    return PSMastersResponse.fromJson(response);
  }
}
