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
      body: FutureBuilder(
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
    );
  }
}
