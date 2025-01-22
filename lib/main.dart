import 'package:app_to_do/business-logic/settings-provider.dart';
import 'package:app_to_do/business-logic/tasks_provider.dart';
import 'package:app_to_do/core/theme.dart';
import 'package:app_to_do/presentation/screens/home-screen.dart';
import 'package:app_to_do/presentation/screens/login-screen.dart';
import 'package:app_to_do/presentation/screens/register-screen.dart';
import 'package:app_to_do/presentation/widgets/edit-task.dart';
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
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SettingsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TasksProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var settingsProvider=Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale:const Locale("ar"),

      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode:settingsProvider.currentTheme,
      initialRoute: LoginScreen.routName,
      routes: {
        ToDoHomeScreen.routName: (context) => const ToDoHomeScreen(),
        Register.routName: (context) => const Register(),
        LoginScreen.routName: (context) => const LoginScreen(),
        EditTask.routName: (context) =>const EditTask(),
      },
    );
  }
}


