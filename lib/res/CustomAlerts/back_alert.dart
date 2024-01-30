import 'package:flutter/cupertino.dart';

class BackAlert {
  showAlert({required BuildContext context, void Function()? onPressed}) {
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
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
              'Are you sure you want to go back? Any unsaved data will be lost.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('CANCEL'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('OK'),
              /*  onPressed: () async {
                /* final prefs = await SharedPreferences.getInstance();
                print("checking :::: ${prefs.containsKey("profilePath")}");
                prefs.clear();
                print(
                    "checking after clear:::: ${prefs.containsKey("profilePath")}"); */

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                /*   Navigator.popUntil(
                  context,
                  ModalRoute.withName(AppRoutes.applicantDashboard),
                ); */
              }, */
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }
}

class FinalSubmitAlert {
  showAlert(
      {required BuildContext context,
      void Function()? onPressed,
      void Function()? onCancel}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext Successcontext) {
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
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text('Are you sure you want submit the data?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('CANCEL'),
              onPressed: onCancel ??
                  () async {
                    Navigator.of(Successcontext).pop();
                  },
            ),
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }
}
