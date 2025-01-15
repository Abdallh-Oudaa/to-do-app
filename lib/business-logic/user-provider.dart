

import 'package:app_to_do/data/firebase/task-dao.dart';
import 'package:app_to_do/data/firebase/user-dao.dart';
import 'package:app_to_do/data/model/task.dart';
import 'package:app_to_do/data/model/user-model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User? userAuth;
  UserModel? userFireBase;
  List<Task> tasks = [];
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

  Future<void> addTaskToFireStore(
      String uid, String title, String description, DateTime dateTime) async {
    // it's related to task not user so i'll move it when i create Task Provider
    Task task =
        Task(title: title, description: description, dateTime: dateTime);
    await TaskDao.addTaskToFireStore(task, uid);
  }

  bool isLoginBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    userFireBase = null;
    userAuth = null;
  }

  Future<List<Task>> getTasksFromFireStore(String uid) async {
    // it's related to task not user so i'll move it when i create Task Provider
    tasks = await TaskDao.getTasksFromFireStore(uid);
    notifyListeners();
    return tasks;
  }

  Future<void> retrieveUser() async{
    // it's func to get user auth and user data from fire store during auto login, i'll work on it later
     userAuth=FirebaseAuth.instance.currentUser;
     userFireBase=await UserDao.getUserFromFireStore(userAuth!.uid);
  }
}
