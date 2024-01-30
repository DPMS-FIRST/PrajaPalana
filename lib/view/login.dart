import 'dart:io';
import 'package:praja_palana/res/CustomAlerts/internet_check_alert.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:praja_palana/res/reusable_widgets/footer_component.dart';
import 'package:praja_palana/res/reusable_widgets/logo_name.dart';
import 'package:praja_palana/utils/internet.dart';
import 'package:praja_palana/utils/reusable_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../res/reusable_widgets/phone_textformfield.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginViewModel>(context);
    TextEditingController _mobileNumber = TextEditingController();
    FocusScopeNode _node = FocusScopeNode();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }
      },
      child: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: CustomFooterContainer(),
            //appBar: MyAppBar(),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.appBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LogoAndName(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 8.0,
                      child: ListView(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.appColor,
                                fontWeight: FontWeight.bold,
                                //decoration: TextDecoration.underline,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          PhoneTextformfield(
                            controller: _mobileNumber,
                            hintText: 'Mobile Number',
                            TextLength: 10,
                            maxLength: 10,
                            obscureText: false,
                            node: _node,
                            action: TextInputAction.next,
                            labelstyle: TextStyle(
                              color: AppColors.appColor,
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              /* FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ), */
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          ReusableButton(
                            onPressed: () async {
                              //Navigator.pushNamed(context, AppRoutes.otp);
                              if (loginProvider.validateUserName(
                                  context, _mobileNumber.text)) {
                                bool isConnected = await InternetCheck();
                                if (isConnected) {
                                  loginProvider.getOfficerLoginViewModel(
                                    context,
                                    _mobileNumber.text.toString().trim(),
                                  );
                                } else {
                                  InternetCheckAlert().showAlert(context);
                                }
                              }
                            },
                            ButtonText: 'LOGIN',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (loginProvider.getIsLoadingStatus) LoaderComponent()
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset('assets/telanganalogo.png'),
      ),
      title: Column(
        children: [
          Container(
            color: AppColors.appColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Text(
                'Telangana State Government'.tr(),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Abhaya Hastham'.tr(),
            style: TextStyle(fontSize: 18, color: AppColors.abhayamColor),
          ),
        ],
      ),
      actions: [
        Image.asset('assets/telanganalogo.png'),
        Image.asset('assets/telanganalogo.png'),
      ],
    );
  }
}
