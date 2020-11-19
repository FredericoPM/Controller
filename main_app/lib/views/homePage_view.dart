import 'package:flutter/material.dart';
import 'package:main_app/views/sideMenu_view.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  bool _theme = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme ?  ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
          drawer: MenuDrawer(),
          appBar: AppBar(
            title: Text("Home page"),
            centerTitle: true,
          ),
        ),
    );
  }
}