import 'package:flutter/material.dart';
import 'file:///C:/Users/Fred/Desktop/facul/Ledstrip_controller/main_app/lib/widgets/sideMenu_widget.dart';
class NormalLight extends StatefulWidget {
  @override
  NormalLightState createState() => NormalLightState();
}
class NormalLightState extends State<NormalLight> {
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
          title: Text("Normal Light"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: RawMaterialButton(
              onPressed: () => {
                setState(() {
                  _lightState = !_lightState;
                }),
              },
              fillColor: Colors.grey[700],
              child: Icon(
                _lightState ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 50.0,
                color: Colors.grey[50],
              ),
              padding: EdgeInsets.all(50.0),
              shape: CircleBorder(),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[900],
                  blurRadius: 5,
                  offset: Offset(0.5,2.5),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}