
import 'package:flutter/material.dart';




class CustomTextField extends StatelessWidget {
 final String? hintText;
  final String? Function(String?) validation;
 final TextInputType keyboardType;
 final TextEditingController controller;
final bool? obsText;
   const CustomTextField( {required this.hintText,
     required this.validation,
     required this.keyboardType,
     required this.controller,
     this.obsText=false,
     super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white,fontSize: 20),
      decoration: InputDecoration(

        hintText: hintText,
          hintStyle:const TextStyle(color: Colors.white),
          errorStyle: const TextStyle(fontSize: 20),

      ),
      obscureText:obsText! ,
      keyboardType: keyboardType,
      validator: validation,
      controller: controller,


    );
  }
}
