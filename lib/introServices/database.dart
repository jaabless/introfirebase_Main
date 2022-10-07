import 'package:introfirebase/introModels/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:introfirebase/introModels/UserModel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name, String hospitalNumber, String gender,
      String date, String id, String email, String phone, String image) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'hospital number': hospitalNumber,
      'gender': gender,
      'date': date,
      'uid': id,
      'email': email,
      'phone': phone,
      'image': image,
    });
  }

  // brew list from snapshot
  List<usermodel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return usermodel(
          name: doc.get('name') ?? "0",
          hospitalNumber: doc.get('hospital number') ?? "0",
          gender: doc.get('gender') ?? '0');
    }).toList();
  }

  // // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        hospitalNumber: snapshot['hospital number'],
        gender: snapshot['gender'],
        date: snapshot['date'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        image: snapshot['image']);
  }

  // get brews stream
  // Stream<List<usermodel>> get brews {
  //   return usersCollection.snapshots().map(_userListFromSnapshot);
  // }

  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<usermodel>> get users {
    return usersCollection.snapshots().map(_userListFromSnapshot);
  }
}
