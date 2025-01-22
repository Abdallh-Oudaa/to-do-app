
import 'package:flutter/material.dart';

class CustomListBox extends StatelessWidget {
 final String typeFiledTitle;
final  String title;

  const CustomListBox({ required this.typeFiledTitle,required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,),
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
           Text(typeFiledTitle),
      const SizedBox(height: 10,),
      Container(
      margin:const EdgeInsets.only(left: 5),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
      color:Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadiusDirectional.circular(5),
      border: Border.all(color: Colors.blue, width: 2),
      ),
      child:  Text(title,
      style:const TextStyle(
      color: Colors.blue,
      )),
      ),
          const SizedBox(height: 15,)
          ]),
    );
  }
}
