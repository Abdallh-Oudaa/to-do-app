import 'package:flutter/material.dart';

class DialogUtils {
 static Future showLoading({required BuildContext context, required String message}) {
    return showDialog(
      context: context,
      builder: (context) {
        return

             AlertDialog(

              content: Row(children: [
               const CircularProgressIndicator(),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(message,style: const TextStyle(fontSize: 20,color: Colors.black),),
                ),
              ],)



        );
      },
    );
  }

 static hideDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

 static Future showMessage(
      {required BuildContext context,
      required String message,
      String? posAction,
      String? negAction,
      VoidCallback? posCallBack,
      VoidCallback? negCallBack}) {
    List<Widget> actions = [];
    if (posAction != null) {
      actions.add(TextButton(
        onPressed: posCallBack,
        child: Text(posAction,style: const TextStyle(fontSize: 20,color: Colors.black),),
      ));
    }
    if (negAction != null) {
      actions.add(TextButton(
        onPressed: negCallBack,
        child: Text(negAction,style: const TextStyle(fontSize: 20,color: Colors.black),),
      ));
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message,style: const TextStyle(fontSize: 20,color: Colors.black),),
            actions: actions,
          );
        });
  }
}
