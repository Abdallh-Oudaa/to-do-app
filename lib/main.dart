import 'package:app_to_do/core/theme.dart';
import 'package:app_to_do/presentation/screens/home-screen.dart';
import 'package:app_to_do/presentation/screens/login-screen.dart';
import 'package:app_to_do/presentation/screens/register-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'business-logic/user-provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      initialRoute: Register.routName,
      routes: {
        ToDoHomeScreen.routName: (context) => const ToDoHomeScreen(),
        Register.routName: (context) => const Register(),
        LoginScreen.routName: (context) => const LoginScreen(),
      },
    );
  }
}

// it's func to auto login i'll work on it later
void navigate(BuildContext context) async {
  var userProvider = Provider.of<UserProvider>(context, listen: false);
  if (userProvider.isLoginBefore()) {
    await userProvider.retrieveUser();
    Navigator.of(context).pushReplacementNamed(ToDoHomeScreen.routName);
  } else {
    Navigator.of(context).pushReplacementNamed(Register.routName);
  }
}
