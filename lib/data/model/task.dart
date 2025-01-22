import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  static String collectionName="tasks";
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  Task({this.id,this.isDone=false,required this.title,required this.description,required this.dateTime});
  Task.fromFireStore(Map<String,dynamic> data){
    id=data['id'];
    title=data['title'];
    description=data['description'];
    dateTime=DateTime.fromMillisecondsSinceEpoch(data['dateTime']);
    isDone=data['isDone'];
  }
  Map<String,dynamic> toFireStore(){
    return{
      "id":id,
      "title":title,
      "description":description,
      "dateTime":dateTime?.millisecondsSinceEpoch,
      "isDone":isDone,


    };
  }


}