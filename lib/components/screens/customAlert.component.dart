import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String titleAlert;
  final String bodyAlert;
  final String textConfirm;

  CustomAlert({this.titleAlert, this.bodyAlert, this.textConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.titleAlert),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(this.bodyAlert),
            //Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(this.textConfirm),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
