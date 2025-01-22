


import 'package:app_to_do/data/firebase/user-dao.dart';

import 'package:app_to_do/data/model/user-model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User? userAuth;
  UserModel? userFireBase;

  Future<void> createUser(String email, String password) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userAuth = credential.user;
  }

  Future<void> login(String email, String password) async {
    var credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    userAuth = credential.user;
  }

  Future<void> addUserToFireStore(UserModel user) async {
    await UserDao.addUserToFireStore(user);
  }

  Future<void> getUserFromFireStore(String uid) async {
    var user = await UserDao.getUserFromFireStore(uid);
    userFireBase = user;
  }



  bool isLoginBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    userFireBase = null;
    userAuth = null;
  }



}
