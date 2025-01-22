

import 'package:app_to_do/business-logic/settings-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowBottomSheetMode extends StatefulWidget {
  const ShowBottomSheetMode({super.key});

  @override
  State<ShowBottomSheetMode> createState() => _ShowBottomSheetModeState();
}

class _ShowBottomSheetModeState extends State<ShowBottomSheetMode> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider=Provider.of<SettingsProvider>(context);
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child:  Column(children: [
        InkWell(
            onTap: (){
              settingsProvider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child:settingsProvider.isDarkEnalbed()?unSelectedItem("Light"):selectedItem("light")),
        InkWell(
            onTap: (){
              settingsProvider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child:settingsProvider.isDarkEnalbed()? selectedItem("Dark"):unSelectedItem("Dark")),
      ],),
    );
  }

  Widget selectedItem(String mode){
    return  ListTile(title: Text(mode,style: const TextStyle(color: Colors.blue),) ,
      trailing: const Icon(Icons.check,color: Colors.blue,), );
  }

  Widget unSelectedItem(String mode){
    return  ListTile(title: Text(mode,style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer,),) ,
      trailing:  Icon(Icons.check,color: Theme.of(context).colorScheme.primaryContainer,), );

  }
}
