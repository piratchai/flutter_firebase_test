import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/components/buttons/rounded.button.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/models/user.model.dart';
import 'package:test_firebase/pages/showusers.page.dart';
import 'package:test_firebase/services/user.service.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double buttonHeight = 45;
  double buttonMinWidth = 150;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this.testUpdateUser();
  }

  void testAddUser() {
    User user = User(username: "piratchai kkk", phone: "0948594833");
    UserService userService = new UserService();
    userService
        .addUser(user)
        .then((value) => print('Add user : ' + value.toString()));
  }

  void testUpdateUser() async {
    User user = User(username: "พงษ์สุด วงษ์ดี", phone: "0947384788");
    UserService userService = new UserService();

    String docNo = '5';

    await userService
        .updateUser(user, docNo)
        .then((value) => print('Update user success.'))
        .catchError((onError) => print('Update user failed.'));

    await userService.getUser(docNo).then((value) => print(
        'Doc : ${value.doc}, Username : ${value.username}, phone :${value.phone}'));

    print('After update user.');
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      titleBackgroudColor: CustomColors.titleBackgroundColor,
      bodyBackground: CustomColors.bodyBackgroundColor,
      title: 'Home Page',
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // -- Show All User -- //
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: RoundedButton(
                    buttonText: 'Show All Users',
                    buttonColor: CustomColors.blueButtonColor,
                    fontSize: RoundedButton.fontSmall,
                    height: this.buttonHeight,
                    minWidth: this.buttonMinWidth,
                    textColor: RoundedButton.whiteText,
                    onPressFunc: () {
                      // Logic Here //
                      //print('First press');
                      Navigator.pushNamed(context, ShowUsersPage.routeName);
                    },
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
