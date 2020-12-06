import 'package:flutter/material.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/models/user.model.dart';
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

  // -- Form key -- //
  final _userFormKey = GlobalKey<FormState>();

  // -- Data -- //
  User user = null;

  // -- Text Editor -- //
  TextEditingController _userDocTxtCtrl = new TextEditingController();
  TextEditingController _userIdTxtCtrl = new TextEditingController();
  TextEditingController _userNameTxtCtrl = new TextEditingController();
  TextEditingController _userPhoneTxtCtrl = new TextEditingController();

  // -- Edit properties -- //
  bool _isEdit = false;
  bool _isInitial = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setEditScreenMode(bool isEdit) {
    setState(() {
      this._isEdit = isEdit;
    });
  }

  Future<User> getUser(String doc) async {
    //User _user;
    await this._userService.getUser(doc).then((value) {
      setState(() {
        user = new User();
        user = value;
        this._userDocTxtCtrl.text = user.doc;
        this._userIdTxtCtrl.text = user.id;
        this._userNameTxtCtrl.text = user.username;
        this._userPhoneTxtCtrl.text = user.phone;

        this._isInitial = false;
      });
    });

    //return _user;
  }

  @override
  Widget build(BuildContext context) {
    // -- Arguments -- //
    final ShowUserArguments _arguments =
        ModalRoute.of(context).settings.arguments;

    if (this._isInitial) this.getUser(_arguments.doc);

    // print("change");

    return CustomScaffold(
      titleBackgroudColor: CustomColors.titleBackgroundColor,
      bodyBackground: CustomColors.bodyBackgroundColor,
      title: 'Show User',
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // -- Future Builder -- //
              // FutureBuilder(
              //   future: this.getUser(_arguments.doc),
              //   builder: (context, snapshet) {
              //     if (snapshet.hasData) {
              //       User userSnap = snapshet.data;

              //       //print(userSnap.username);

              //       return Column(
              //         children: [Text('Username : ${userSnap.username}')],
              //       );
              //     } else if (snapshet.hasError) {
              //       return Text('Error');
              //     }

              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              // ),

              // -- TextEditor -- //
              user != null
                  ? Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Form(
                        key: this._userFormKey,
                        child: Column(
                          children: [
                            // -- Doc Text Field -- //
                            TextFormField(
                              controller: this._userDocTxtCtrl,
                              decoration:
                                  InputDecoration(labelText: 'User Doc'),
                              //initialValue: user.doc,
                              enabled: false,
                            ),
                            // -- UserId Text Field -- //
                            TextFormField(
                              controller: this._userIdTxtCtrl,
                              decoration: InputDecoration(labelText: 'UserID'),
                              //initialValue: user.id,
                              enabled: false,
                            ),
                            // -- Username Text Field -- //
                            TextFormField(
                              controller: this._userNameTxtCtrl,
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'พิมพ์ชื่อของคุณ'),
                              enabled: this._isEdit,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enter, your name';
                                }
                                return null;
                              },
                              //initialValue: user.username,
                            ),
                            // -- Phone Text Field -- //
                            TextFormField(
                              controller: this._userPhoneTxtCtrl,
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: 'พิมพ์เบอร์ของคุณ'),
                              enabled: this._isEdit,
                              //initialValue: user.phone,
                            ),
                            // -- Edit Button -- //
                            !this._isEdit
                                ? Container(
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: RoundedButton(
                                      buttonText: 'แก้ไข',
                                      buttonColor: CustomColors.blueButtonColor,
                                      fontSize: RoundedButton.fontMedium,
                                      height: RoundedButton.buttonHeight,
                                      minWidth: RoundedButton.buttonMinWidth,
                                      textColor: RoundedButton.whiteText,
                                      onPressFunc: () {
                                        // Logic Here //
                                        //print('First press');
                                        this.setEditScreenMode(true);
                                      },
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // -- Confirm Button -- //
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 30, 0),
                                        child: RoundedButton(
                                          buttonText: 'ตกลง',
                                          buttonColor:
                                              CustomColors.confirmButtonColor,
                                          fontSize: RoundedButton.fontMedium,
                                          height: RoundedButton.buttonHeight,
                                          minWidth:
                                              RoundedButton.buttonMinWidth,
                                          textColor: RoundedButton.whiteText,
                                          onPressFunc: () {
                                            // Logic Here //
                                            //print('First press');
                                          },
                                        ),
                                      ),
                                      // -- Cancel Button -- //
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: RoundedButton(
                                          buttonText: 'ยกเลิก',
                                          buttonColor:
                                              CustomColors.cancelButtonColor,
                                          fontSize: RoundedButton.fontMedium,
                                          height: RoundedButton.buttonHeight,
                                          minWidth:
                                              RoundedButton.buttonMinWidth,
                                          textColor: RoundedButton.whiteText,
                                          onPressFunc: () {
                                            // Logic Here //
                                            //print('First press');
                                            this.setEditScreenMode(false);
                                            this.getUser(_arguments.doc);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          )
        ],
      ),
    );
  }
}
