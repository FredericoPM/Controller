import 'package:flutter/material.dart';
import 'package:main_app/widgets/colorPicker_widget.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';

import 'package:main_app/widgets/desconected_widget.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/connection_controller.dart';
class RGBLight extends StatefulWidget {
  String title;
  RGBLight(this.title);
  @override
  _RGBLightState createState() => _RGBLightState(title);
}
class _RGBLightState extends State<RGBLight> {
  String title;
  _RGBLightState(this.title);
  bool _lightState = false;
  Color atualColor = Colors.blue;
  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    String connection = Provider.of<ConnectionController>(context).connection;
    if(connection == 'MQTTConnectionState.connected'){
      if(
      Provider.of<ConnectionController>(context).manager.recivedData != null
          && Provider.of<ConnectionController>(context).manager.recivedData.length >= title.length
          && Provider.of<ConnectionController>(context).manager.recivedData.substring(0, title.length) == title
      ){
        _lightState = Provider.of<ConnectionController>(context).manager.recivedData == "$title|1";
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: connection != 'MQTTConnectionState.disconnected'  ? null :[
            Desconected(),
          ],
        ),
        body: Center(
          child: CircleColorPicker(
            initialColor: atualColor,
            onChanged: (color) {
              if( (color.red - atualColor.red).abs() >= 2 || (color.green - atualColor.green).abs() >= 2 || (color.blue - atualColor.blue).abs() >= 2){
                atualColor = color;
                if(connection == 'MQTTConnectionState.connected'){
                  Provider.of<ConnectionController>(context, listen: false).publishMessage("$title|${color.red},${color.green},${color.blue}");
                }
              }
            },
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
                if(connection == 'MQTTConnectionState.connected'){
                  Provider.of<ConnectionController>(context, listen: false).publishMessage(_lightState ? "$title|1" : "$title|0"),
                }
              },
              child: _lightState ? Icon(Icons.lightbulb) : Icon(Icons.lightbulb_outline),
            ),
          ),
        )
      )
    );
  }
}