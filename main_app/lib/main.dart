import 'package:flutter/material.dart';
import 'package:main_app/views/homePage_view.dart';
void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        title: "Light controller",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      )
  );
}
