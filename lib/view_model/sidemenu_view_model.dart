import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../routes/app_routes.dart';

class SideMenuViewModel with ChangeNotifier {
  navigationTo(BuildContext context, subtitle) async {
    if (subtitle == 'Home') {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else if (subtitle == 'Attendance') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.privacy_policy);
    } else if (subtitle == 'Approve Team Attendance') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.privacy_policy);
    } else if (subtitle == 'Team Attendance') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.privacy_policy);
    } else if (subtitle == 'Download Masters') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.downloadMasters);
    } else if (subtitle == 'Reports') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.dashboardReport);
    } else if (subtitle == 'Privacy Policy') {
      Navigator.pop(context);
      Navigator.pushNamed(
        context,
        AppRoutes.privacy_policy,
      );
    } else if (subtitle == 'App Info') {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.appInfo);
    } else if (subtitle == 'Exit application') {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Exit application?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Are you sure you want to Exit from this application?",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'NO',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: const Text(
                      'YES',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } else if (subtitle == 'Logout') {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Logout application?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Are you sure you want to Logout from this application?",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'NO',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, AppRoutes.login),
                    child: const Text(
                      'YES',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } else if (subtitle == 'Grids') {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else if (subtitle == 'GridsInCard') {
      Navigator.pop(context);
      //Navigator.pushReplacementNamed(context, AppRoutes.dashboard2);
    } else if (subtitle == 'ListView') {
      Navigator.pop(context);
      //Navigator.pushReplacementNamed(context, AppRoutes.dashboard3);
    } else if (subtitle == 'HorizontalListView') {
      Navigator.pop(context);
      //Navigator.pushReplacementNamed(context, AppRoutes.dashboard4);
    } else if (subtitle == 'HorizontalVerticalListView') {
      Navigator.pop(context);
      //Navigator.pushReplacementNamed(context, AppRoutes.dashboard5);
    }
    /* 'Dashboard View-Grids', 'image': AppAssets.appIcon},
        {'title': 'Dashboard View-GridsInCard', 'image': AppAssets.appIcon},
        {'title': 'Dashboard View-ListView', 'image': AppAssets.appIcon},
        {'title': 'Dashboard View-HorizontalListView', 'image': AppAssets.appIcon},
        {'title': 'Dashboard View-HorizontalVerticalListView', 'image': AppAssets.appIcon}, */
  }
}
