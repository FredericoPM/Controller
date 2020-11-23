import 'package:flutter/material.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';

import 'package:main_app/widgets/desconected_widget.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/connection_controller.dart';
class SliderLight extends StatefulWidget {
  @override
  SliderLightState createState() => SliderLightState();
}
class SliderLightState extends State<SliderLight> {
  double _lightState = 0;
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool connected = Provider.of<ConnectionController>(context).connected;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text("Slider Light"),
          centerTitle: true,
          actions: connected ? null :[
            Desconected(),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.lightbulb,
              color: Colors.grey[400],
              size: 30.0,
            ),
            Container(
              height: 400,
              child: RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  value: _lightState,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      _lightState = value;
                    });
                  },
                  activeColor: Colors.grey,
                  inactiveColor: Colors.grey[700],
                ),
              ),
            ),
            Icon(
              Icons.lightbulb_outline,
              color: Colors.grey[400],
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}