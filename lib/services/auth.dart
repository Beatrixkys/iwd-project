import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:website_wireframe/services/database.dart';

import '../models/usermodel.dart';

class AuthService extends ChangeNotifier {
//create instance of FirebaseAuth,set login status to false
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoggedIn = false;

//create an instance of the user from the firebase authentication table
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser!).uid;
  }

  Future signInWithEmailAndPassword(
      String sEmail, String sPassword, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: sEmail, password: sPassword);
      User? user = result.user;

      if (user == null) {
        throw Exception("No user found");
      }

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  Future register(String email, String password, String name, String number,
      BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = result.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;

//add user to firestore database
      DatabaseService(user!.uid).saveUser(name, email, number);

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      String message = e.toString();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  //signout

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
