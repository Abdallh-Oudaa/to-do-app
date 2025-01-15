import 'package:app_to_do/business-logic/user-provider.dart';
import 'package:app_to_do/core/const-string.dart';
import 'package:app_to_do/data/model/user-model.dart';
import 'package:app_to_do/email-regex.dart';
import 'package:app_to_do/presentation/widgets/dialog-utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom-text-field.dart';
import 'login-screen.dart';

class Register extends StatefulWidget {
  static const String routName = "register";

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController firstName = TextEditingController(text: "abd");

  final TextEditingController lastName = TextEditingController(text: "ali");

  final TextEditingController email =
      TextEditingController(text: "mo12@gmail.com");

  final TextEditingController password = TextEditingController(text: "mo1212");

  final TextEditingController confirmPassword =
      TextEditingController(text: "mo1212");

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
                CustomTextField(
                  hintText: "first name",
                  validation: (text) {
                    if (text!.trim().isEmpty) {
                      return "filed is empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: firstName,
                ),
                CustomTextField(
                  hintText: "last name",
                  validation: (text) {
                    if (text!.trim().isEmpty) {
                      return "filed is empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: lastName,
                ),
                CustomTextField(
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
                CustomTextField(
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
                CustomTextField(
                  obsText: true,
                  hintText: "confirm password",
                  validation: (text) {
                    if (text!.trim().isEmpty) {
                      return "filed is empty";
                    }
                    if (text.length < 6) {
                      return "password is too short";
                    }
                    if (password.text != confirmPassword.text) {
                      return "not same password";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: confirmPassword,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: MaterialButton(
                      color: Colors.white,
                      textColor: Colors.white,
                      minWidth: 200,
                      onPressed: () {
                        addAccount();
                      },
                      child: Text(
                        "Add account",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.black),
                      )),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routName);
                    },
                    child: const Text(
                      "i already have an account",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addAccount() async {
    if (formKey.currentState?.validate() == true) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        DialogUtils.showLoading(context: context, message: "loading");
        await userProvider.createUser(email.text, password.text);
        UserModel user = UserModel(
            id: userProvider.userAuth?.uid,
            firstName: firstName.text,
            lastName: lastName.text,
            email: email.text);
        await userProvider.addUserToFireStore(user);
       if (!mounted) return; // i used it because there is error said that Don't use 'BuildContext's across async gaps

        DialogUtils.hideDialog(context: context);
        DialogUtils.showMessage(
            context: context,
            message: "user created successfully",
            posAction: "ok",
            posCallBack: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == ConstString.weakPassword) {
          DialogUtils.hideDialog(context: context);
          DialogUtils.showMessage(
              context: context,
              message: 'The password provided is too weak.',
              posCallBack: () {
                DialogUtils.hideDialog(context: context);
              },
              posAction: "ok");
        } else if (e.code == ConstString.emailUsed) {
          DialogUtils.hideDialog(context: context);
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              posCallBack: () {
                DialogUtils.hideDialog(context: context);
              },
              posAction: "ok");
        } else if (e.code == ConstString.networkError) {
          DialogUtils.hideDialog(context: context);
          DialogUtils.showMessage(
              context: context,
              message: 'network error',
              posCallBack: () {
                DialogUtils.hideDialog(context: context);
              },
              posAction: "ok");
        }
      } catch (e) {
        DialogUtils.hideDialog(context: context);
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            posCallBack: () {
              DialogUtils.hideDialog(context: context);
            },
            posAction: "ok");
      }
    }
  }
}
