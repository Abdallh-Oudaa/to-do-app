import 'package:app_to_do/business-logic/settings-provider.dart';
import 'package:app_to_do/presentation/widgets/bottom-sheet-language.dart';
import 'package:app_to_do/presentation/widgets/custom-list-box.dart';
import 'package:app_to_do/presentation/widgets/show-bottom-sheet-mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTap extends StatefulWidget {
  const SettingsTap({super.key});

  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider=Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  showBottomSheetLanguage();
                },
                child: const CustomListBox(
                    typeFiledTitle: "Language", title: "English")),
            InkWell(
                onTap: () {
                  showBottomSheetMode();
                },
                child:  CustomListBox(
                    typeFiledTitle: "Mode", title: settingsProvider.currentTheme ==ThemeMode.light?"Light":"Dark")),
          ],
        ),
      ),
    );
  }

  Future showBottomSheetLanguage() {
     return showModalBottomSheet(context: context,
       builder: (context) =>const ShowBottomSheetLanguage(),);
  }
  Future showBottomSheetMode() {
    return showModalBottomSheet(context: context,
      builder: (context) => const ShowBottomSheetMode(),);
  }
}
