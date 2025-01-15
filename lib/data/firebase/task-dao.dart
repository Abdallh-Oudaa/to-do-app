import 'dart:ffi';

import 'package:app_to_do/data/firebase/user-dao.dart';
import 'package:app_to_do/data/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDao{
  static CollectionReference<Task> getTasksCollection(String uid){
   return UserDao.getUserCollection().doc(uid).collection(Task.collectionName).
    withConverter(fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()??{}),
        toFirestore: (task, options) =>task.toFireStore() ,);
  }
static Future<void> addTaskToFireStore(Task task,String uid)async {
    var dbDocument= getTasksCollection(uid).doc();
     task.id=dbDocument.id;
    return dbDocument.set(task);
  }
static Future<List<Task>> getTasksFromFireStore(String uid)async{
  QuerySnapshot <Task> querySnapshot=  await getTasksCollection(uid).get();
  List<Task> tasks= querySnapshot.docs.map((e) => e.data(),).toList();
  return tasks;
  }

  static Future<void> deleteTask(String uid,String taskId)async {
    await getTasksCollection(uid).doc(taskId).delete();
  }

}