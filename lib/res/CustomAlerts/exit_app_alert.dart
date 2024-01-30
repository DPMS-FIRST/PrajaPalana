import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ExitAppAlert {
  showAlert({required BuildContext context}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                CupertinoIcons.info,
                size: 60.0,
                color: CupertinoColors.systemBlue,
              ),
              SizedBox(height: 8.0),
              Text(
                'Exit App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
                if (Platform.isIOS) {
                  exit(0);
                } else {
                  SystemNavigator.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
