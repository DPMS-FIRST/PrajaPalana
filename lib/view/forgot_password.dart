import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:praja_palana/res/reusable_widgets/phone_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/constants/app_assets.dart';
import '../utils/reusable_button.dart';
import '../view_model/reset_password_view_model.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController mobileNocontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ResetPasswordProvider = Provider.of<ResetPasswordViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("RESET PASSWORD"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AppAssets.appIcon),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: PhoneTextformfield(
                  hintText: AppStrings.mobileNumber,
                  controller: mobileNocontroller,
                ),
              ),
              ReusableButton(
                ButtonText: "Continue",
                onPressed: () {
                  ResetPasswordProvider.ResetPassword(
                      mobileNocontroller.text, context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
