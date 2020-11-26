import 'package:flutter/material.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';

import 'package:main_app/widgets/desconected_widget.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/connection_controller.dart';
class NormalLight extends StatefulWidget {
  String title;
  NormalLight(this.title);
  @override
  _NormalLightState createState() => _NormalLightState(title);
}
class _NormalLightState extends State<NormalLight> {
  String title;
  _NormalLightState(this.title);
  bool _lightState = false;
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String connection = Provider.of<ConnectionController>(context).connection;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: connection != 'MQTTConnectionState.disconnected'? null :[
            Desconected(),
          ],
        ),
        body: Center(
          child: Container(
            child: RawMaterialButton(
              onPressed: () => {
                setState(() {
                  _lightState = !_lightState;
                }),
                Provider.of<ConnectionController>(context, listen: false).publishMessage(_lightState? "1" : "0")
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