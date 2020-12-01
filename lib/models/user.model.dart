import 'dart:convert';

class User {
  final String id;
  final String username;
  final String phone;
  final String doc;

  User({this.id, this.phone, this.username, this.doc});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'],
        username: jsonData['username'],
        phone: jsonData['phone'],
        doc: jsonData['doc']);
  }
}
