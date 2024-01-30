import 'package:flutter/cupertino.dart';
import 'package:praja_palana/res/constants/app_strings.dart';

class AlertwithTwoButtons {
  showAlert({
    required BuildContext context,
    String? title,
    required String message,
    required VoidCallback onYesPressed,
    required VoidCallback onNoPressed,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.question_circle,
                size: 60.0,
                color: CupertinoColors.systemBlue,
              ),
              SizedBox(height: 8.0),
              Text(
                title ?? AppStrings.appName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'No',
                style: TextStyle(color: CupertinoColors.systemRed),
              ),
              onPressed: onNoPressed,
            ),
            CupertinoDialogAction(
              child: Text(
                'Yes',
                style: TextStyle(color: CupertinoColors.systemBlue),
              ),
              onPressed: onYesPressed,
            ),
          ],
        );
      },
    );
  }
}
