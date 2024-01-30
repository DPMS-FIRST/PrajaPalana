import 'package:flutter/widgets.dart';
import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/applicant_details/applicant_schemewise_details_response.dart';
import 'package:praja_palana/models/remarks_model.dart';
import '../models/applicant_details/applicant_schemewise_payload.dart';
import '../res/constants/api_constants.dart';

class ApplicantDetailsRepository with ChangeNotifier {
  final _baseClient = BaseApiClient();
/*   Future<GetApplicantDetailsResponse?> getApplicantDetailsRepository(
      BuildContext context, GetApplicantDetailsPayload payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.getApplicantDetails,
      payload.toJson(),
    );
    return GetApplicantDetailsResponse.fromJson(response);
  } */

  Future<ApplicationSchemeResponse?> getApplicationSchemeRepository(
      BuildContext context, ApplicationSchemewisePayload payload) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.getApplicationScheme,
      payload.toJson(),
    );
    return ApplicationSchemeResponse.fromJson(response);
  }

  Future<GetRemarksResponse?> getRemarksRepository(BuildContext context) async {
    final response = await _baseClient.postCall(
      context,
      ApiConstants.getRemarks,
      {},
    );
    return GetRemarksResponse.fromJson(response);
  }
}
