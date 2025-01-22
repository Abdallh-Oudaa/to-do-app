
import 'package:app_to_do/business-logic/tasks_provider.dart';
import 'package:app_to_do/business-logic/user-provider.dart';

import 'package:app_to_do/presentation/widgets/dialog-utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/model/task.dart';

class EditTask extends StatefulWidget {
  static const String routName="edit task";

   const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController title=TextEditingController();

  TextEditingController description=TextEditingController();

  DateTime? backDateTime;
 static  Task? task;
 var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {



    task=ModalRoute.of(context)!.settings.arguments as Task;
    title.text=task!.title!;
    description.text=task!.description!;
    backDateTime=task!.dateTime!;
    return Scaffold(

        appBar: AppBar(
          iconTheme:  IconThemeData(color: Theme.of(context).colorScheme.secondary),
        title: Text(
        "To Do List",
        style: Theme.of(context).textTheme.headlineLarge,
    ),),
      body:
         AlertDialog(
backgroundColor:Theme.of(context).colorScheme.secondary,
          content: Form(
            key:formKey ,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Text(
                    "Edit Task",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: title,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Please Enter a title";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter your task",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff848486)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: TextFormField(
                    controller: description,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter a description";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter your Description",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff848486)),
                    ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(

                    "Select item",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                InkWell(
                  onTap: () {
                    calenderShow();

                  },
                  child: Center(
                      child: Text(
                        DateFormat.MEd().format(backDateTime ?? DateTime.now()),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff848486)),
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      minWidth: 300,
                      onPressed: () {
                        editTask(task!);
                      },
                      child: Text(
                        "Save Changes",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                ),
              ],),
          ),
        ),

    );
  }

  void calenderShow() async {
    var dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    backDateTime = dateTime;
  }
  Future<void> editTask(Task task) async {
    var taskProvider=Provider.of<TasksProvider>(context,listen: false);
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    if (formKey.currentState?.validate() == true) {

     task.title=title.text;
     task.description=description.text;
     task.dateTime=backDateTime;
     DialogUtils.showLoading(context: context, message: "loading");
      await taskProvider.editTask(userProvider.userAuth!.uid,task);
     await taskProvider.getTasksFromFireStore(userProvider.userAuth!.uid);
      DialogUtils.hideDialog(context: context);
      Navigator.pop(context);
    }}
}
