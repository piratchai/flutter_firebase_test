import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_firebase/models/user.model.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String collectionName = "users";

  Future<List<User>> getAllUsers() async {
    CollectionReference userCollectoin = firestore.collection(collectionName);

    List<User> _users = new List<User>();
    await userCollectoin.get().then((QuerySnapshot qSnap) {
      qSnap.docs.forEach((QueryDocumentSnapshot qDocSnap) {
        //print(qDocSnap.data());
        User _user = User.fromJson(qDocSnap.data());
        //print(user.username);

        _users.add(_user);
      });
    });

    return _users;
  }

  Future<User> getUser(String doc) async {
    CollectionReference userCollectoin = firestore.collection(collectionName);

    User _user;
    await userCollectoin.doc(doc).get().then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        //print(docSnap.data());
        _user = User.fromJson(docSnap.data());
      } else {
        _user = null;
      }
    });

    return _user;
  }

  Future<int> getNextDocNo() async {
    CollectionReference userCollectoin = firestore.collection(collectionName);

    String doc = "";
    await userCollectoin
        .orderBy('doc', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.length > 0)
        value.docs.forEach((element) {
          //print(element.id);
          doc = element.id;
        });
      else
        doc = "0";
    });
    int nextNo = 0;
    nextNo = int.parse(doc) + 1;

    print(nextNo);
    return nextNo;
  }

  Future<bool> addUser(User user) async {
    CollectionReference userCollectoin = firestore.collection(collectionName);

    var nextNo = "";
    await this.getNextDocNo().then((value) => nextNo = value.toString());

    bool isSuccess = false;

    await userCollectoin
        .doc(nextNo)
        .set({
          "doc": nextNo,
          "id": "-",
          "username": user.username,
          "phone": user.phone
        })
        .then((value) => isSuccess = true)
        .catchError((error) => isSuccess = false);

    return isSuccess;
  }

  Future<bool> updateUser(User user, String docNo) async {
    CollectionReference userCollectoin = firestore.collection(collectionName);

    bool isSuccess = false;

    await userCollectoin
        .doc(docNo)
        .update({'username': user.username, 'phone': user.phone})
        .then((value) => isSuccess = true)
        .catchError((error) => isSuccess = false);

    return isSuccess;
  }
}
