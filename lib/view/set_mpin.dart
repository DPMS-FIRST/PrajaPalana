import 'package:flutter/services.dart';
import 'package:praja_palana/models/login/validate_login_details_response.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/reusable_widgets/app_input_text.dart';
import 'package:praja_palana/res/reusable_widgets/footer_component.dart';
import 'package:praja_palana/res/reusable_widgets/logo_name.dart';
import 'package:praja_palana/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import '../res/constants/app_assets.dart';
import '../utils/reusable_button.dart';
import '../view_model/set_mpin_view_model.dart';

class SetMPINPage extends StatefulWidget {
  SetMPINPage({super.key});

  @override
  State<SetMPINPage> createState() => _SetMPINPageState();
}

class _SetMPINPageState extends State<SetMPINPage> {
  TextEditingController mpinController = TextEditingController();
  TextEditingController confirmMpinController = TextEditingController();
  double? height;
  double? width;
  String? mpin;
  String? Confirm_mpin;
  ValidLoginDetailsResponse? loginResponse = ValidLoginDetailsResponse();

  @override
  Widget build(BuildContext context) {
    final setMpinProvider = Provider.of<SetMpinViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: CustomFooterContainer(),
            body: Container(
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LogoAndName(),
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              AppInputText(
                                text: "Set Mpin",
                                color: AppColors.appColor,
                                fontweight: FontWeight.bold,
                                fontsize: 18.0,
                              ),
                              PinCodeFields(
                                obscureCharacter: '⬤',
                                obscureText: true,
                                length: 4,
                                fieldBorderStyle: FieldBorderStyle.square,
                                controller: mpinController,
                                responsive: false,
                                fieldHeight: 50.0,
                                fieldWidth: 50.0,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                borderWidth: 2.0,
                                activeBorderColor: Colors.black,
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
                                  this.mpin = mpin;
                                  print("Mpin: $mpin");
                                },
                              ),
                              AppInputText(
                                text: "Confirm Mpin",
                                color: AppColors.appColor,
                                fontweight: FontWeight.bold,
                                fontsize: 18.0,
                              ),
                              PinCodeFields(
                                  length: 4,
                                  obscureCharacter: '⬤',
                                  obscureText: true,
                                  fieldBorderStyle: FieldBorderStyle.square,
                                  controller: confirmMpinController,
                                  responsive: false,
                                  fieldHeight: 50.0,
                                  fieldWidth: 50.0,
                                  borderWidth: 2.0,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  activeBorderColor: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                  keyboardType: TextInputType.number,
                                  autoHideKeyboard: true,
                                  borderColor: AppColors.appColor,
                                  textStyle: TextStyle(
                                    color: AppColors.appColor,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onComplete: (Confirm_mpin) {
                                    this.Confirm_mpin = Confirm_mpin;
                                    print("Confirm :$Confirm_mpin");
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReusableButton(
                                  onPressed: () {
                                    setMpinProvider
                                      ..generateMPIN(
                                          context,
                                          loginResponse,
                                          mpinController.text.toString(),
                                          confirmMpinController.text
                                              .toString());
                                  },
                                  ButtonText: 'Submit',
                                ),
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
          if (setMpinProvider.getIsLoadingStatus()) LoaderComponent()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loginViewModel =
          Provider.of<LoginViewModel>(context, listen: false);

      setState(() {
        loginResponse = loginViewModel.getLoginDetails;
      });
    });
  }
}
