import 'package:flutter/material.dart';

class CustomDialog {
  // CustomAlert(
  //     {this.titleAlert, this.bodyAlert, this.textConfirm, this.isPopScreen});

  static dynamic showResultDialog(BuildContext context, String titleAlert,
      String bodyAlert, String textConfirm, bool isPopScreen) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleAlert),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(bodyAlert),
                // Text(
                //     'Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(textConfirm),
              onPressed: () {
                Navigator.of(context).pop();
                if (isPopScreen) Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> showConfirmDialog(BuildContext context, String titleAlert,
      String bodyAlert, String textConfirm, String textCancel) async {
    bool isConfirm = false;

    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleAlert),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(bodyAlert),
                // Text(
                //     'Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(textConfirm),
              onPressed: () {
                Navigator.of(context).pop();
                isConfirm = true;
              },
            ),
            TextButton(
              child: Text(textCancel),
              onPressed: () {
                Navigator.of(context).pop();
                isConfirm = false;
              },
            ),
          ],
        );
      },
    );

    return isConfirm;
  }
}
