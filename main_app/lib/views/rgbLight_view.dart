import 'package:flutter/material.dart';
import 'file:///C:/Users/Fred/Desktop/facul/Ledstrip_controller/main_app/lib/widgets/colorPicker_widget.dart';
import 'file:///C:/Users/Fred/Desktop/facul/Ledstrip_controller/main_app/lib/widgets/sideMenu_widget.dart';
class RGBLight extends StatefulWidget {
  @override
  RGBLightState createState() => RGBLightState();
}
class RGBLightState extends State<RGBLight> {
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
          title: Text("RGB Light"),
          centerTitle: true,
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
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              foregroundColor: Colors.grey[50],
              backgroundColor: Colors.grey[700],
              onPressed: () =>{
                setState(() {
                  _lightState = !_lightState;
                }),
              },
              child: _lightState ? Icon(Icons.lightbulb) : Icon(Icons.lightbulb_outline),
            ),
          ),
        )
      )
    );
  }
}