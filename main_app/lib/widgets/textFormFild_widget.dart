import 'package:flutter/material.dart';
class BuildTextFormFild extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  String hintText;

  BuildTextFormFild({this.controller, this.labelText, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      validator: (s) {
        if (s.isEmpty)
          return "Digite o nome!";
        else
          return null;
      },
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100], width: 2),
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          color:  Colors.grey[600],
        ),
        labelStyle: TextStyle(
          color:  Colors.grey[200],
        ),
      ),
      style: TextStyle(color: Colors.grey[300]),
    );
  }
}
