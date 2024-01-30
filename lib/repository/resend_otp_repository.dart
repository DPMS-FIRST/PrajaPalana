import 'package:praja_palana/data/base_api_client.dart';
import 'package:praja_palana/models/login/resend_otp_response.dart';
import 'package:flutter/material.dart';
import '../models/login/resend_otp_payload.dart';
import '../res/constants/api_constants.dart';

class ResendOTPRepository {
  final _baseApiClinet = BaseApiClient();
  Future<ResendOtpResponse?> getResendOTPRepo(
      BuildContext context, ResendOtpPayload payload) async {
    final response = await _baseApiClinet.postCall(
      context,
      ApiConstants.RESEND_OTP,
      payload.toJson(),
    );
    return ResendOtpResponse.fromJson(response);
  }
}
