import 'package:app_to_do/business-logic/user-provider.dart';
import 'package:app_to_do/data/firebase/task-dao.dart';
import 'package:app_to_do/presentation/widgets/calender.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/task.dart';
import '../widgets/task.dart';

class TaskListTap extends StatelessWidget {
  TaskListTap({super.key});
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    tasks = userProvider.tasks;

    return Scaffold(
      body: Column(
        children: [
          const Calender(),
          const SizedBox(
            height: 10,
          ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) => TaskItem(task: tasks[index]),
          itemCount: tasks.length,
        ),
      ),

        ],
      ),
    );
  }
}
/*  FutureBuilder(future: TaskDao.getTasksFromFireStore(userProvider.userAuth!.uid),
            builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            else{
              return   Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => TaskItem(task: snapshot.data![index]),
                  itemCount: snapshot.data?.length,
                ),
              );
            }
          },),*/
