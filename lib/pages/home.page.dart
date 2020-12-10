import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/components/buttons/rounded.button.dart';
import 'package:test_firebase/components/colors/colors.component.dart';
import 'package:test_firebase/components/screens/customScaffold.component.dart';
import 'package:test_firebase/pages/showusers.page.dart';

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
  }

  void testDeleteUser(String doc) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String collectionName = "users";

    CollectionReference userCollectoin = firestore.collection(collectionName);

    await userCollectoin
        .doc(doc)
        .delete()
        .then((value) => print('User Doc : ${doc} was deleted'))
        .catchError((onError) => print('Error occured when deleting'));
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

              // -- Add User -- //
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              //   child: Center(
              //     child: RoundedButton(
              //       buttonText: 'Add User',
              //       buttonColor: CustomColors.blueButtonColor,
              //       fontSize: RoundedButton.fontSmall,
              //       height: this.buttonHeight,
              //       minWidth: this.buttonMinWidth,
              //       textColor: RoundedButton.whiteText,
              //       onPressFunc: () {
              //         // Logic Here //
              //         //print('First press');
              //         //Navigator.pushNamed(context, ShowUsersPage.routeName);
              //       },
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
