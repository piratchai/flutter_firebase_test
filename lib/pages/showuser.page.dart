import 'package:flutter/material.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/models/user.model.dart';
import 'package:test_firebase/screenArguments/showuser.argument.dart';
import 'package:test_firebase/services/user.service.dart';

class ShowUserPage extends StatefulWidget {
  static const String routeName = "showUser";

  @override
  _ShowUserPageState createState() => _ShowUserPageState();
}

class _ShowUserPageState extends State<ShowUserPage> {
  // -- Service -- //
  UserService _userService = new UserService();

  // -- Form key -- //
  final _userFormKey = GlobalKey<FormState>();

  // -- Text Editor -- //
  //TextEditingController _userIdTxtCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<User> getUser(String doc) async {
    User _user;
    await this._userService.getUser(doc).then((value) {
      _user = value;
    });

    return _user;
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
            children: [
              // -- Future Builder -- //
              FutureBuilder(
                future: this.getUser(_arguments.doc),
                builder: (context, snapshet) {
                  if (snapshet.hasData) {
                    User userSnap = snapshet.data;

                    //print(userSnap.username);

                    return Column(
                      children: [Text('Username : ${userSnap.username}')],
                    );
                  } else if (snapshet.hasError) {
                    return Text('Error');
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

              // -- TextEditor -- //
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Form(
                  key: this._userFormKey,
                  child: Column(
                    children: [
                      // -- UserId Text Field -- //
                      TextFormField(
                        //controller: this._userIdTxtCtrl,
                        decoration: InputDecoration(labelText: 'UserID'),
                        initialValue: '-',
                        enabled: false,
                      ),
                      // -- Username Text Field -- //
                      TextFormField(
                        //controller: this._userIdTxtCtrl,
                        decoration: InputDecoration(
                            labelText: 'Username', hintText: 'พิมพ์ชื่อของคุณ'),
                        enabled: true,
                      ),
                      // -- Username Text Field -- //
                      TextFormField(
                        //controller: this._userIdTxtCtrl,
                        decoration: InputDecoration(
                            labelText: 'Phone', hintText: 'พิมพ์เบอร์ของคุณ'),
                        enabled: true,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
