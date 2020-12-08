import 'package:flutter/material.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/models/user.model.dart';
import 'package:test_firebase/screenArguments/showuser.argument.dart';
import 'package:test_firebase/services/user.service.dart';

import '../components/buttons/rounded.button.dart';
import '../models/user.model.dart';

class ViewUserPage extends StatefulWidget {
  static const String routeName = "viewUser";

  @override
  _ViewUserPageState createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  // -- Service -- //
  UserService _userService = new UserService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // -- Arguments -- //
    final ShowUserArguments _arguments =
        ModalRoute.of(context).settings.arguments;

    return CustomScaffold(
      titleBackgroudColor: CustomColors.titleBackgroundColor,
      bodyBackground: CustomColors.bodyBackgroundColor,
      title: 'Show User',
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Form(
                  child: Column(
                    children: [
                      // -- Doc Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(labelText: 'User Doc'),
                        initialValue: _arguments.doc,
                        enabled: false,
                      ),
                      // -- UserId Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(labelText: 'UserID'),
                        initialValue: _arguments.id,
                        enabled: false,
                      ),
                      // -- Username Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username', hintText: 'พิมพ์ชื่อของคุณ'),
                        enabled: false,
                        initialValue: _arguments.username,
                      ),
                      // -- Phone Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Phone', hintText: 'พิมพ์เบอร์ของคุณ'),
                        enabled: false,
                        initialValue: _arguments.phone,
                      ),
                      // -- Edit Button -- //
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: RoundedButton(
                          buttonText: 'กลับ',
                          buttonColor: CustomColors.blueButtonColor,
                          fontSize: RoundedButton.fontMedium,
                          height: RoundedButton.buttonHeight,
                          minWidth: RoundedButton.buttonMinWidth,
                          textColor: RoundedButton.whiteText,
                          onPressFunc: () {
                            // Logic Here //
                            //print('back press');
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
