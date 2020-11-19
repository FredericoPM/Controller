import 'package:flutter/material.dart';
import 'package:main_app/views/sideMenu_view.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text("Slider Light"),
          centerTitle: true,
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