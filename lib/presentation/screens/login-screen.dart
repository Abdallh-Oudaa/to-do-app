import 'package:app_to_do/business-logic/user-provider.dart';
import 'package:app_to_do/core/const-string.dart';
import 'package:app_to_do/email-regex.dart';
import 'package:app_to_do/presentation/screens/home-screen.dart';

import 'package:app_to_do/presentation/screens/register-screen.dart';
import 'package:app_to_do/presentation/widgets/dialog-utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom-text-field.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = "login screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email =
      TextEditingController(text: "mo122@gmail.com");

  final TextEditingController password = TextEditingController(text: "mo1212");

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("Assets/images/backgroundImage.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: CustomTextField(
                    hintText: "email",
                    validation: (text) {
                      if (text!.trim().isEmpty) {
                        return "filed is empty";
                      }
                      if (validateEmail(email.text) != null) {
                        return "enter a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  child: CustomTextField(
                    obsText: true,
                    hintText: "password ",
                    validation: (text) {
                      if (text!.trim().isEmpty) {
                        return "filed is empty";
                      }
                      if (text.length < 6) {
                        return "password is too short";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    controller: password,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                      color: Colors.white,
                      textColor: Colors.white,
                      minWidth: 200,
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        "login",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.black),
                      )),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Register.routName);
                    },
                    child: const Text(
                      "don't have an account",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context: context, message: "loading");
        await userProvider.login(email.text, password.text);
       await userProvider.getUserFromFireStore(userProvider.userAuth?.uid??"");
       await userProvider.getTasksFromFireStore(userProvider.userAuth!.uid);

        if(!mounted)return;
        DialogUtils.hideDialog(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "loge in  successfully",
        );
        DialogUtils.hideDialog(context: context);
        Navigator.pushReplacementNamed(context, ToDoHomeScreen.routName);
      } on FirebaseAuthException catch (e) {
        if (e.code == ConstString.userNotFound) {
          DialogUtils.hideDialog(context: context);
          DialogUtils.showMessage(
              context: context,
              message: "No user found for that email.",
              posAction: "ok",
              posCallBack: () {
                Navigator.pop(context);
              });
        } else if (e.code == ConstString.wrongPassword) {
          DialogUtils.hideDialog(context: context);
          DialogUtils.showMessage(
              context: context,
              message: "Wrong password provided for that user.",
              posAction: "ok",
              posCallBack: () {
                Navigator.pop(context);
              });
        } else if (e.code == ConstString.networkError) {
          DialogUtils.hideDialog(context: context);
          DialogUtils.showMessage(
              context: context,
              message: "network error",
              posAction: "ok",
              posCallBack: () {
                Navigator.pop(context);
              });
        }
      } catch (e) {
        DialogUtils.showMessage(
            context: context, message: 'Unexpected error during sign-in: $e');
      }
    }
  }
}
