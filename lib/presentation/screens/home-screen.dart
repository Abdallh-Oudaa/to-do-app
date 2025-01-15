import 'package:app_to_do/business-logic/user-provider.dart';
import 'package:app_to_do/presentation/screens/login-screen.dart';
import 'package:app_to_do/presentation/screens/settings-tap.dart';
import 'package:app_to_do/presentation/screens/task-list-tap.dart';
import 'package:app_to_do/presentation/widgets/dialog-utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom-sheet.dart';

class ToDoHomeScreen extends StatefulWidget {
  static String routName = "homeScreen";

  const ToDoHomeScreen({super.key});

  @override
  State<ToDoHomeScreen> createState() => _ToDoHomeScreenState();
}

class _ToDoHomeScreenState extends State<ToDoHomeScreen> {
  int? clickIndex;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        leading: InkWell(
          onTap: () {
            DialogUtils.showMessage(
                context: context,
                message: "are you sure to log out ?",
                posAction: "yas",
                negAction: "cancel",
                posCallBack: () {
                  userProvider.logOut();
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routName);
                },
                negCallBack: () {
                  Navigator.pop(context);
                });


          },
          child: const Icon(Icons.logout,color: Colors.white,),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: clickIndex ?? 0,
            onTap: (index) {
              clickIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 21,
                    weight: 22,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 21,
                    weight: 22,
                  ),
                  label: ""),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTaskShowBottomSheet();
            setState(() {});
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: taps[clickIndex ?? 0],
    );
  }

  List<Widget> taps = [
     TaskListTap(),
    const SettingsTap(),
  ];
  Future addTaskShowBottomSheet() {
    return showModalBottomSheet(
        context: (context), builder: ((context) => const BottomSheetWidget()));
  }
}
