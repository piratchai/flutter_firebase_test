import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  // -- AppBar -- //
  final String title;
  final Color titleBackgroudColor;
  final List<Widget> appbarListWidget;

  // -- Body -- //
  final Widget body;
  final Color bodyBackground;

  // -- construct -- //
  CustomScaffold(
      {this.title,
      this.titleBackgroudColor,
      this.body,
      this.bodyBackground,
      this.appbarListWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        backgroundColor: this.titleBackgroudColor,
        actions: this.appbarListWidget,
      ),
      body: this.body,
      backgroundColor: this.bodyBackground,
    );
  }
}
