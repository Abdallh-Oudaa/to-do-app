import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../data/firebase/task-dao.dart';
import '../data/model/task.dart';

class TasksProvider extends ChangeNotifier{
  List<Task> tasks=[];
  Future<void> addTaskToFireStore(
      String uid, String title, String description, DateTime dateTime) async {

    Task task =
    Task(title: title, description: description, dateTime: dateTime);
    await TaskDao.addTaskToFireStore(task, uid);
    notifyListeners();
  }
  Future<List<Task>> getTasksFromFireStore(String uid) async {

    tasks = await TaskDao.getTasksFromFireStore(uid);
    notifyListeners();
    return tasks;
  }
  Future<void> removeTask(String uid,String taskId) async {

    await TaskDao.deleteTask(uid,taskId);
    notifyListeners();
  }
  Future<void> updateIsDone(String uid,Task task)async{
   return TaskDao.editIsDone(uid,  task);
  }
  Future<void> editTask(String uid,Task task)async{
   return await TaskDao.editTask(uid, task);
  }
}