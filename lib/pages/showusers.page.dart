import 'package:flutter/material.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/models/user.model.dart';
import 'package:test_firebase/pages/edituser.page.dart';
import 'package:test_firebase/pages/showuser.page.dart';
import 'package:test_firebase/pages/viewuser.page.dart';
import 'package:test_firebase/screenArguments/showuser.argument.dart';
import 'package:test_firebase/services/user.service.dart';

class ShowUsersPage extends StatefulWidget {
  static const String routeName = "showUsers";

  @override
  _ShowUsersPageState createState() => _ShowUsersPageState();
}

class _ShowUsersPageState extends State<ShowUsersPage> {
  UserService _userService = new UserService();

  List<User> _users = new List<User>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAllUsers();
  }

  void getAllUsers() async {
    var _usersFuture = await this._userService.getAllUsers();

    // -- Test Result --//
    // print(_usersFuture.length.toString());
    // print('Ater get users');

    // -- fill data to state variable -- //
    _usersFuture.forEach((e) {
      //print(e.doc);
      setState(() {
        this._users.add(e);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      titleBackgroudColor: CustomColors.titleBackgroundColor,
      bodyBackground: CustomColors.bodyBackgroundColor,
      title: 'Show All User',
      body: this._users.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                User _user = this._users[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        child: Column(
                      children: [
                        // -- ListTile -- //
                        ListTile(
                          title: Text('Username : ${_user.username}'),
                          subtitle: Text(
                              'User ID : ${_user.id}, Phone : ${_user.phone}, Doc : ${_user.doc}'),
                          onTap: () {
                            // -- //
                            //print(_user.id);
                            // Navigator.pushNamed(
                            //   context,
                            //   ShowUserPage.routeName,
                            //   arguments: ShowUserArguments(doc: _user.doc),
                            // );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 120, 0),
                              child: // -- View Icon Button -- //
                                  IconButton(
                                icon: Icon(Icons.attribution_rounded),
                                onPressed: () {
                                  //print('View');
                                  Navigator.pushNamed(
                                    context,
                                    ViewUserPage.routeName,
                                    arguments: ShowUserArguments(
                                        doc: _user.doc,
                                        id: _user.id,
                                        username: _user.username,
                                        phone: _user.phone),
                                  );
                                },
                                tooltip: 'View',
                              ),
                            ),

                            // -- Edit Icon Button -- //
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                //print('Edit');
                                Navigator.pushNamed(
                                  context,
                                  EditUserPage.routeName,
                                  arguments: ShowUserArguments(
                                      doc: _user.doc,
                                      id: _user.id,
                                      username: _user.username,
                                      phone: _user.phone),
                                );
                              },
                              tooltip: 'Edit',
                            )
                          ],
                        )
                      ],
                    )),
                  ],
                );
              },
              itemCount: _users.length)
          : Center(
              child: CircularProgressIndicator(
                  //backgroundColor: Colors.pinkAccent,
                  ),
            ),
    );
  }
}
