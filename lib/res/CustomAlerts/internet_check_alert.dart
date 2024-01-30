import 'package:flutter/cupertino.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class InternetCheckAlert {
  showAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 13, color: AppColors.black),
              ),
              SizedBox(height: 8.0),
              Text(
                "Please check your internet connection and try again.",
                style: TextStyle(fontSize: 12, color: AppColors.black),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                AppStrings.ok,
                style: TextStyle(color: AppColors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
