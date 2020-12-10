import 'package:flutter/material.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customDialog.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/constants/constants.dart';
import 'package:test_firebase/models/user.model.dart';
import 'package:test_firebase/screenArguments/showuser.argument.dart';
import 'package:test_firebase/services/user.service.dart';

import '../components/buttons/rounded.button.dart';
import '../models/user.model.dart';

class AddUserPage extends StatefulWidget {
  static const String routeName = "addUser";

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  // -- Service -- //
  UserService _userService = new UserService();

  // -- TextController -- //
  TextEditingController _usernameTxtCtrl = new TextEditingController();
  TextEditingController _phoneTxtCtrl = new TextEditingController();

  // -- doc -- //
  String doc = "";

  // -- formKey -- //
  final _editForm = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getNextDoc();
  }

  void getNextDoc() async {
    await this._userService.getNextDocNo().then((value) {
      setState(() {
        doc = value.toString();
      });
    }).catchError((onError) {
      print('Error when get last doc');
    });
  }

  void addUser(User user, BuildContext context) async {
    await this._userService.addUser(user).then((value) {
      if (value) {
        //
        CustomDialog.showResultDialog(context, Constants.alertBoxMsg,
            'เพิ่มสำเร็จ จะกลับไปหน้าหลัก', 'รับทราบ', true);
      }
    }).catchError((onError) {
      print('Error when add user');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      titleBackgroudColor: CustomColors.titleBackgroundColor,
      bodyBackground: CustomColors.bodyBackgroundColor,
      title: 'Add User',
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
                      this.doc != ""
                          ? TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'User Doc'),
                              enabled: false,
                              initialValue: this.doc,
                            )
                          : Text(''),
                      // -- UserId Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(labelText: 'UserID'),
                        initialValue: '-',
                        enabled: false,
                      ),
                      // -- Username Text Field -- //
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username', hintText: 'พิมพ์ชื่อของคุณ'),
                        enabled: true,
                        autofocus: true,
                        //initialValue: _arguments.username,
                        controller: this._usernameTxtCtrl,
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
                        controller: this._phoneTxtCtrl,
                        keyboardType: TextInputType.number,
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
                                  // -- add user -- //
                                  String username = this._usernameTxtCtrl.text;
                                  String phone = this._phoneTxtCtrl.text;
                                  User user = new User(
                                      id: "", username: username, phone: phone);
                                  this.addUser(user, context);
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
