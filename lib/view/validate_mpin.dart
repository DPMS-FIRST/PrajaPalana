import 'package:flutter/services.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/reusable_widgets/app_input_text.dart';
import 'package:praja_palana/res/reusable_widgets/footer_component.dart';
import 'package:praja_palana/res/reusable_widgets/logo_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import '../res/constants/app_assets.dart';
import '../utils/reusable_button.dart';
import '../view_model/validate_mpin_view_model.dart';

class ValidateMpin extends StatefulWidget {
  ValidateMpin({super.key});

  @override
  State<ValidateMpin> createState() => _ValidateMpinState();
}

class _ValidateMpinState extends State<ValidateMpin> {
  double? height;

  double? width;

  String? Mpin;

  TextEditingController? contrller1;

  TextEditingController? contrller2;

  TextEditingController? contrller3;

  TextEditingController? contrller4;
  ValidLoginDetailsResponse? loginResponse = ValidLoginDetailsResponse();

  @override
  Widget build(BuildContext context) {
    final validateMpinProvider = Provider.of<ValidateMpinViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: CustomFooterContainer(),
          /*   appBar: AppBarComponent(
            automaticallyImplyLeading: false,
          ), */
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.appBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LogoAndName(),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            AppInputText(
                              text: "Validate Mpin",
                              color: AppColors.appColor,
                              fontweight: FontWeight.bold,
                              fontsize: 18.0,
                            ),
                            PinCodeFields(
                              length: 4,
                              fieldBorderStyle: FieldBorderStyle.square,
                              controller: contrller1,
                              responsive: false,
                              fieldHeight: 50.0,
                              fieldWidth: 50.0,
                              borderWidth: 2.0,
                              obscureCharacter: '⬤',
                              obscureText: true,
                              activeBorderColor: Colors.black,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              keyboardType: TextInputType.number,
                              autoHideKeyboard: true,
                              borderColor: AppColors.appColor,
                              textStyle: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                              onComplete: (mpin) {
                                // Your logic with pin code
                                Mpin = mpin;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      validateMpinProvider.notYOU(context);
                                    },
                                    child: Text(
                                      "Not You?",
                                      style: TextStyle(
                                          //decoration: TextDecoration.underline,
                                          color: AppColors.appColor,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      validateMpinProvider.forgotMPIN(
                                          context, loginResponse);
                                    },
                                    child: Text(
                                      "Forgot Mpin",
                                      style: TextStyle(
                                          //decoration: TextDecoration.underline,
                                          color: AppColors.appColor,
                                          fontSize: 18.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ReusableButton(
                              ButtonText: "Validate",
                              onPressed: () {
                                validateMpinProvider.validateMpin(
                                  Mpin ?? "",
                                  context,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);
      await loginViewModel.getLoginResponseDetails();

      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
      });
    });
  }
}
