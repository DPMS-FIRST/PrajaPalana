import 'package:praja_palana/models/master_data/master_geograpics_response.dart';

import '../data/base_api_client.dart';
import '../models/master_data/master_data_response.dart';
import '../res/constants/api_constants.dart';

class DownloadMastersRepository {
  final _baseApiClinet = BaseApiClient();
  Future<MasterDataResponse?> downloadMastersRepo(context) async {
    final response = await _baseApiClinet.getCall(
      context,
      ApiConstants.download_masters,
    );
    return MasterDataResponse.fromJson(response);
  }
  Future<GeographicsMastersResponse?> downloadGeographicsMastersRepo(context) async {
    final response = await _baseApiClinet.getCall(
      context,
      ApiConstants.getGeoGrapicMaters,
    );
    return GeographicsMastersResponse.fromJson(response);
  }
}
