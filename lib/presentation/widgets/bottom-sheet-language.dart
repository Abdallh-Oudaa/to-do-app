

import 'package:flutter/material.dart';

class ShowBottomSheetLanguage extends StatefulWidget {
  const ShowBottomSheetLanguage({super.key});

  @override
  State<ShowBottomSheetLanguage> createState() => _ShowBottomSheetLanguageState();
}

class _ShowBottomSheetLanguageState extends State<ShowBottomSheetLanguage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child:  Column(children: [
        selectedItem("English"),
      unSelectedItem("العربيه"),
      ],),
    );
  }

  Widget selectedItem(String language){
    return  ListTile(title: Text(language,style: const TextStyle(color: Colors.blue),) ,
      trailing: const Icon(Icons.check,color: Colors.blue,), );
  }

  Widget unSelectedItem(String language){
    return  ListTile(title: Text(language,style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer,),) ,
      trailing:  Icon(Icons.check,color: Theme.of(context).colorScheme.primaryContainer,), );

  }
}
