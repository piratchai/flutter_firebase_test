import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  // -- Functions -- //
  final Function onPressFunc;

  // -- Button Color -- //
  final Color buttonColor;

  // -- Text Color -- //
  final Color textColor;

  // -- Text -- //
  final String buttonText;

  // -- static fontSize properties -- //
  static const double fontSmall = 15;
  static const double fontMedium = 20;
  static const double fontLarge = 35;

  // -- static button size properties -- //
  static const double buttonHeight = 45;
  static const double buttonMinWidth = 150;

  // -- static Text Color properties -- //
  static const Color whiteText = Colors.white;
  static const Color blackText = Colors.black;

  // -- fontSize -- //
  final double fontSize;

  // -- button size -- //
  final double minWidth;
  final double height;

  RoundedButton(
      {this.onPressFunc,
      this.buttonColor,
      this.buttonText,
      this.fontSize,
      this.minWidth,
      this.height,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: this.minWidth,
      height: this.height,
      child: RaisedButton(
        onPressed: this.onPressFunc,
        color: this.buttonColor,
        child: Text(
          this.buttonText,
          style: TextStyle(fontSize: this.fontSize, color: this.textColor),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: this.buttonColor)),
      ),
    );
  }
}
