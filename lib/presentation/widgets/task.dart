import 'package:app_to_do/business-logic/tasks_provider.dart';
import 'package:app_to_do/business-logic/user-provider.dart';

import 'package:app_to_do/presentation/widgets/dialog-utils.dart';
import 'package:app_to_do/presentation/widgets/edit-task.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../core/theme.dart';
import '../../data/model/task.dart';
import 'calender.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({required this.task, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TasksProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, EditTask.routName,arguments: widget.task);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          height: 115,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 4,
                  height: 80,
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : MyTheme.primaryColor,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title ?? "title out",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: widget.task.isDone!
                              ? MyTheme.greenColor
                              : MyTheme.primaryColor),
                    ),
                    Text(
                      widget.task.description ?? "description out",
                      style:  TextStyle(color:  widget.task.isDone!
                          ? MyTheme.greenColor
                          : Theme.of(context).colorScheme.primaryContainer,
                          fontSize: 15, fontWeight: FontWeight.w600,),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                 widget.task.isDone = !widget.task.isDone!;
                  taskProvider.updateIsDone(
                      userProvider.userAuth!.uid, widget.task);
                  setState(() {});
                },
                child: widget.task.isDone!
                    ? Text(
                        "Done!",
                        style: TextStyle(color: MyTheme.greenColor, fontSize: 30),
                      )
                    : Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: MyTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(
        context: context,
        message: "are you sure to delete!",
        posAction: "yas",
        posCallBack: () async {
          await removeTask();
          await refreshTasksList();
          if (!mounted) return;
          DialogUtils.hideDialog(context: context);
        },
        negAction: "cancel",
        negCallBack: () {
          DialogUtils.hideDialog(context: context);
        });
  }

  Future<void> removeTask() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);

    await tasksProvider.removeTask(
        userProvider.userAuth!.uid, widget.task.id ?? "");
  }

  Future<void> refreshTasksList() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var taskProvider = Provider.of<TasksProvider>(context, listen: false);

    await taskProvider.getTasksFromFireStore(userProvider.userAuth!.uid);
  }
}
