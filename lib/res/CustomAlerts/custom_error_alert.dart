import 'package:praja_palana/res/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';

class ErrorCustomCupertinoAlert {
  showAlert(BuildContext context,
      {required String message, void Function()? onPressed}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.xmark_circle,
                size: 60.0,
                color: CupertinoColors.systemBlue,
              ),
              SizedBox(height: 8.0),
              Text(
                AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                AppStrings.ok,
                textAlign: TextAlign.center,
              ),
              onPressed: onPressed ?? () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
