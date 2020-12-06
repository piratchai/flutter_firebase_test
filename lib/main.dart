import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_firebase/pages/edituser.page.dart';
import 'package:test_firebase/pages/home.page.dart';
import 'package:test_firebase/pages/showuser.page.dart';
import 'package:test_firebase/pages/showusers.page.dart';
import 'package:test_firebase/pages/viewuser.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => runApp(MyApp()));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      home: HomePage(),
      // home: Container(
      //   child: Text('Test'),
      // ),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        ShowUsersPage.routeName: (context) => ShowUsersPage(),
        ShowUserPage.routeName: (context) => ShowUserPage(),
        ViewUserPage.routeName: (context) => ViewUserPage(),
      },
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String resultFirebase = "";

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this.initialFirebase();
    this.getAllData();
    //this.getUser(1);
  }

  void getAllData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    users.get().then((QuerySnapshot qSnap) {
      qSnap.docs.forEach((QueryDocumentSnapshot qDocSnap) {
        print(qDocSnap.data());
      });
    });
  }

  void getUser(int userId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('users');

    user.doc(userId.toString()).get().then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        print(docSnap.data());
      }
    });
  }

  void initialFirebase() async {
    var a = await Firebase.initializeApp();
    print(a);
    setState(() {
      this.resultFirebase = a.toString();
    });

    if (a.toString() == "FirebaseApp([DEFAULT])") {
      print('Started');
      // -- Get data from document --
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference users = firestore.collection('users');
      //print(users.doc('0').get());
      var doc = users.doc('0').get();
      doc.then((DocumentSnapshot docSnap) {
        if (docSnap.exists) {
          print('Document has data');
          print(docSnap.data());
        } else {
          print('Documennt has no data');
        }
      });
    } else {
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                'Test Screen!!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                resultFirebase,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FutureBuilder(
            future: this._initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Failed to load firebase',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // -- Get data from document --
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference users = firestore.collection('users');

                // -- all document --
                List<Map<String, dynamic>> _jsonLst =
                    List<Map<String, dynamic>>();

                users.get().then((QuerySnapshot qSnap) => {
                      //print(
                      //'Data length : ' + qSnap.docs.length.toString()),
                      qSnap.docs.forEach((doc) {
                        _jsonLst.add(doc.data());
                        //print(doc.data());
                      })
                    });
                //.whenComplete(() => {print('get all docs complete')});

                // -- extract each doc doc --
                // var doc = users.doc('0').get();
                // doc.then((DocumentSnapshot docSnap) {
                //   if (docSnap.exists) {
                //     print('Document has data');
                //     //print(docSnap.data());
                //     var jsonData = docSnap.data();
                //     print(jsonData['username']);
                //   } else {
                //     print('Documennt has no data');
                //   }
                // });

                var _txtSuccess = Text(
                  'Success to load firebase',
                  style: TextStyle(color: Colors.green),
                );

                //var _listTile = ListTile()

                return _txtSuccess;
              }

              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
