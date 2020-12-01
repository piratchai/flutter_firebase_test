import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/components/buttons/rounded.button.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
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

    //this.testAddFirestore();
  }

  void testAddFirestore() async {
    UserService _user = new UserService();

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userCollectoin = firestore.collection('users');

    var nextNo = "";
    await _user.getNextDocNo().then((value) => nextNo = value.toString());

    userCollectoin
        .doc(nextNo)
        .set({"doc": nextNo, "id": "-", "username": "A", "phone": "0948594844"})
        .then((value) => print('Add user successful.'))
        .catchError((error) => print('error'));
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
