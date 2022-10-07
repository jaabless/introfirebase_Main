import 'package:cloud_firestore/cloud_firestore.dart';

class usermodel {
  final String name;
  final String hospitalNumber;
  final String gender;

  usermodel(
      {required this.name, required this.hospitalNumber, required this.gender});
}
//.....................

class UserModel {
  String email;
  String name;
  String image;
  Timestamp date;
  String uid;

  UserModel(
      {required this.email,
      required this.name,
      required this.image,
      required this.date,
      required this.uid});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      image: snapshot['image'],
      date: snapshot['date'],
      uid: snapshot['uid'],
    );
  }
}
