import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    //final splashProvider = Provider.of<SplashViewModel>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppAssets.splash != ""
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAssets.splash),
                        fit: BoxFit.fill),
                  ),
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColors.themeColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(AppAssets.appIcon),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome to",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "Praja Palana",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final splashProvider =
          Provider.of<SplashViewModel>(context, listen: false);
      await splashProvider.splashService(context);
    });
  }
}
