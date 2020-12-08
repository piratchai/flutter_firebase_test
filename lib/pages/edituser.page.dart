import 'package:flutter/material.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customAlert.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/models/user.model.dart';
import 'package:test_firebase/pages/showusers.page.dart';
import 'package:test_firebase/screenArguments/showuser.argument.dart';
import 'package:test_firebase/services/user.service.dart';

import '../components/buttons/rounded.button.dart';
import '../models/user.model.dart';

class EditUserPage extends StatefulWidget {
  static const String routeName = "editUser";

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  // -- Service -- //
  UserService _userService = new UserService();

  // user doc //
  String userDoc = "";

  // -- TextController -- //
  TextEditingController _usernameTxtCtrl;
  TextEditingController _phoneTxtCtrl;

  // -- formKey -- //
  final _editForm = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> editUser(User user) async {
    bool success = false;
    await this
        ._userService
        .updateUser(user, user.doc)
        .then((value) => success = value)
        .catchError((onError) => success = false);
    return success;
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
                  key: this._editForm,
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
                        enabled: true,
                        autofocus: true,
                        //initialValue: _arguments.username,
                        controller: this._usernameTxtCtrl =
                            new TextEditingController(
                                text: _arguments.username),
                        //onChanged: (text) {},
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'กรุณาพิมพ์ชื่อ';
                          }
                          return null;
                        },
                      ),
                      // -- Phone Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Phone', hintText: 'พิมพ์เบอร์ของคุณ'),
                        enabled: true,
                        //initialValue: _arguments.phone,
                        controller: this._phoneTxtCtrl =
                            new TextEditingController(text: _arguments.phone),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'กรุณาพิมพ์เบอร์';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // -- Confirm Button -- //
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 30, 0),
                            child: RoundedButton(
                              buttonText: 'ตกลง',
                              buttonColor: CustomColors.blueButtonColor,
                              fontSize: RoundedButton.fontMedium,
                              height: RoundedButton.buttonHeight,
                              minWidth: RoundedButton.buttonMinWidth,
                              textColor: RoundedButton.whiteText,
                              onPressFunc: () {
                                // Logic Here //
                                //print('back press');
                                if (this._editForm.currentState.validate()) {
                                  // -- edit user -- //
                                  User user = new User(
                                      doc: _arguments.doc,
                                      id: _arguments.id,
                                      username: this._usernameTxtCtrl.text,
                                      phone: this._phoneTxtCtrl.text);

                                  this.editUser(user).then((value) {
                                    if (value) {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('แจ้งเตือน'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text('อัพเดทข้อมูลสำเร็จ'),
                                                  // Text(
                                                  //     'Would you like to approve of this message?'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('ยอมรับ'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  });
                                } else {
                                  return;
                                }
                              },
                            ),
                          ),
                          // -- Cancel Button -- //
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: RoundedButton(
                              buttonText: 'กลับ',
                              buttonColor: CustomColors.cancelButtonColor,
                              fontSize: RoundedButton.fontMedium,
                              height: RoundedButton.buttonHeight,
                              minWidth: RoundedButton.buttonMinWidth,
                              textColor: RoundedButton.whiteText,
                              onPressFunc: () {
                                // Logic Here //
                                Navigator.pop(context, true);
                              },
                            ),
                          ),
                        ],
                      )
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
