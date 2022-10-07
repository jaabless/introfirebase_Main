import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:introfirebase/introServices/database.dart';
import 'package:introfirebase/modelsNinja/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  mainUser? _userFromFirebaseUser(User? user) {
    return user != null ? mainUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<mainUser?> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // AuthService MyAuthService = AuthService();

  // Stream<mainUser?> get user =>FirebaseAuth.instance
  // .authStateChanges()
  // .map(_userFromFirebaseUser);

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      // print(error.toString());
      errorMessage(error.toString());
      return null;
    }
  }

  void errorMessage(String message) {
    showToastMessage(message);
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      final date = DateTime.now();
      final uid = result.user!.uid;
      // final name = result.user!.displayName
      await DatabaseService(uid: user!.uid).updateUserData('New User', 'HN0001',
          'Male', '$date', '$uid', 'user@gmail.com', '0245323651', 'adfa');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 73, 73, 73),
      textColor: Colors.white,
      fontSize: 16.0);
}
