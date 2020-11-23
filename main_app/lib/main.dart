import 'package:flutter/material.dart';
import 'package:main_app/views/homePage_view.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/connection_controller.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => ConnectionController(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
          ),
          title: "Light controller",
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      )
  );
}
