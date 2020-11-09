import 'package:flutter/material.dart';
import 'package:main_app/views/colorPicker_view.dart';
import 'package:main_app/views/sideMenu_view.dart';
class RGBlight extends StatefulWidget {
  @override
  RGBlightState createState() => RGBlightState();
}
class RGBlightState extends State<RGBlight> {
  bool _lightState = false;
  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          /*
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () =>{

            },
          ),
          */
          title: Text("RGB Light"),

          centerTitle: true,

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.wb_sunny_outlined),
              tooltip: 'Tema',
              onPressed: () => {},
            )
          ],

        ),
        body: Center(
          child: CircleColorPicker(
            initialColor: Colors.blue,
            onChanged: (color) => print(color),
            size: const Size(320, 320),
            strokeWidth: 4,
            thumbSize: 36,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.grey[50],
          backgroundColor: Colors.grey[700],
          onPressed: () =>{
            setState(() {
              _lightState = !_lightState;
            }),
          },
          child: _lightState ? Icon(Icons.lightbulb) :Icon(Icons.lightbulb_outline),
        ),
      )
    );
  }
}