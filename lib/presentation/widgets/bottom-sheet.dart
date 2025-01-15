import 'package:app_to_do/business-logic/user-provider.dart';
import 'package:app_to_do/data/firebase/task-dao.dart';
import 'package:app_to_do/presentation/widgets/dialog-utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var formKey = GlobalKey<FormState>();
  DateTime? backDateTime;
  TextEditingController title = TextEditingController(text: "first task");
  TextEditingController description =
      TextEditingController(text: "first description");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              TextFormField(
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
              TextFormField(
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
              Text(
                "Select item",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              InkWell(
                onTap: () {
                  calenderShow();
                  setState(() {});
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
              MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: 300,
                  onPressed: () {
                    addTask();
                    setState(() {});
                  },
                  child: Text(
                    "Add",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
            ],
          ),
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

  void flutterToast() {
    Fluttertoast.showToast(
        msg: "Task Add successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> addTask() async {
    if (formKey.currentState?.validate() == true) {
      backDateTime ??= DateTime.now();
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      DialogUtils.showLoading(context: context, message: "loading");

      await userProvider.addTaskToFireStore(userProvider.userAuth?.uid ?? "",
          title.text, description.text, backDateTime!).then((value) {

        if (!mounted) return;
        userProvider.getTasksFromFireStore(userProvider.userAuth!.uid);

        DialogUtils.hideDialog(context: context);

        Navigator.pop(context);

        flutterToast();
       /* print("user from fire auth ========================>");
        print(userProvider.userAuth?.uid);
        print(userProvider.userAuth?.email);
        print(userProvider.userFireBase?.email);
        print("user from fire base ========================>");
        print(userProvider.userFireBase?.id);
        print(userProvider.userFireBase?.firstName);
        print(userProvider.userFireBase?.email);*/
          },);


    }
  }
}
