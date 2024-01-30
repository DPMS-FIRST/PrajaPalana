import 'package:praja_palana/data/sharedpreferences/share_pref_constants.dart';
import 'package:praja_palana/res/constants/app_assets.dart';
import 'package:praja_palana/res/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:praja_palana/res/reusable_widgets/appbar_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfoView extends StatefulWidget {
  const AppInfoView({super.key});

  @override
  State<AppInfoView> createState() => _AppInfoViewState();
}

class _AppInfoViewState extends State<AppInfoView> {
  String? lastupdatedDate;
  String? versionNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: "App Info",
        onPressedBack: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.appBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                radius: 40,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: Image.asset(AppAssets.sixGuaranteeImage)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Version :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.appColor),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "$versionNumber",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.appColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Last updated date :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.appColor),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "$lastupdatedDate",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.appColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchVersion();
  }

  Future<void> fetchVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final updatedDate =
        await prefs.getString("${SharedConstants.lastUpdateDate}");
    final localVersion =
        await prefs.getString("${SharedConstants.versionNumver}");
    print("updatedDate ${updatedDate}");
    setState(() {
      lastupdatedDate = updatedDate;
      versionNumber = localVersion;
    });
  }
}
