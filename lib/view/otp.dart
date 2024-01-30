import 'dart:async';
import 'package:flutter/services.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/CustomAlerts/custom_error_alert.dart';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/footer_component.dart';
import 'package:praja_palana/res/reusable_widgets/logo_name.dart';
import 'package:praja_palana/routes/app_routes.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/reusable_widgets/app_input_text.dart';
import '../view_model/otp_view_model.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  double? height;
  double? width;
  late Timer _timer;
  int _start = 30; // Timer duration in seconds
  bool _resendEnabled = false;
  int? mobileOtp;
  ValidLoginDetailsResponse? loginResponse = ValidLoginDetailsResponse();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await loginViewModel.getLoginResponseDetails();
      mobileOtp = await prefs.getInt('OTP') ?? 0;
      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
        mobileOtp;
      });
    });
    /* setState(() {
      mobile;
    }); */
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _resendEnabled = true; // Enable the resend button
          _timer.cancel(); // Stop the timer
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      _start = 30; // Reset the timer duration
      _resendEnabled = false; // Disable the resend button
      startTimer(); // Start the timer again
    });
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: CustomFooterContainer(),
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.appBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoAndName(),
                  Card(
                    surfaceTintColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        AppInputText(
                          text: AppStrings.verificationCode,
                          fontweight: FontWeight.bold,
                          fontsize: 18.0,
                          color: AppColors.appColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppInputText(
                            text: AppStrings.sentCodeToMobileNo,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PinCodeFields(
                              obscureText: true,
                              length: 4,
                              fieldBorderStyle: FieldBorderStyle.square,
                              controller: otpController,
                              responsive: false,
                              fieldHeight: 50.0,
                              fieldWidth: 50.0,
                              borderWidth: 2.0,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              activeBorderColor: Colors.black,
                              borderRadius: BorderRadius.circular(6.0),
                              keyboardType: TextInputType.number,
                              autoHideKeyboard: true,
                              borderColor: AppColors.appColor,
                              textStyle: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                              obscureCharacter: '⬤',
                              onComplete: (String value) {},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Resend OTP in $_start seconds ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _resendEnabled
                                    ? TextButton(
                                        onPressed: () async {
                                          mobileOtp = 0;
                                          if (await InternetCheck()) {
                                            
                                            await otpProvider.getResendOtpVM(
                                                context, loginResponse);
                                            setState(() {
                                              mobileOtp =
                                                  otpProvider.getResendOtp;
                                              print("otp in resend $mobileOtp");
                                            });
                                          } else {
                                            ErrorCustomCupertinoAlert()
                                                .showAlert(
                                              context,
                                              message:
                                                  "${AppStrings.internet_check}",
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          }

                                          resetTimer(); // Reset the timer
                                        },
                                        child: Text(
                                          'Resend OTP',
                                          style: TextStyle(
                                              color: AppColors.primaryColorDark,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: height! / 28,
                            ),
                            ReusableButton(
                              ButtonText: "Verify",
                              onPressed: () async {
                                print("otp:: $mobileOtp");
                                //Navigator.pushNamed(context, AppRoutes.setMpin);
                                /*  otpProvider.validateSentOtp(
                                    context, sentOtp, otpController); */
                                if (otpProvider.otpValidateFields(
                                    context, otpController.text, mobileOtp)) {
                                  print(
                                      "otp, service otp::${otpController.text}, ${mobileOtp}");
                                  bool isConnected = await InternetCheck();
                                  if (isConnected) {
                                    Navigator.pushNamed(
                                        context, AppRoutes.setMpin);
                                  } else {
                                    InternetCheckAlert().showAlert(context);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (otpProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }
}
