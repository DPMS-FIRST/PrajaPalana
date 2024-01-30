import 'package:flutter/cupertino.dart';
import '../constants/app_strings.dart';

class SuccessCustomCupertinoAlert {
  showAlert(
      {required BuildContext context,
      required String title,
      void Function()? onPressed}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.checkmark_alt_circle,
                size: 60.0,
                color: CupertinoColors.systemGreen,
              ),
              SizedBox(height: 8.0),
              Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(title),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                AppStrings.ok,
              ),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }
}
