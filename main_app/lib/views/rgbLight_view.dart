import 'package:flutter/material.dart';
import 'package:main_app/widgets/colorPicker_widget.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';

import 'package:main_app/widgets/desconected_widget.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/connection_controller.dart';
class RGBLight extends StatefulWidget {
  final String title;
  final int id;
  RGBLight(this.title, this.id);
  @override
  _RGBLightState createState() => _RGBLightState(title, id);
}
class _RGBLightState extends State<RGBLight> {
  String title;
  int id;
  _RGBLightState(this.title, this.id);
  bool _lightState = false;
  Color atualColor = Colors.blue;

  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    Provider.of<ConnectionController>(context).loadData();
    if(Provider.of<ConnectionController>(context).loaded && !Provider.of<ConnectionController>(context).tryedConnection){
      Provider.of<ConnectionController>(context).startConnection();
    }
    String connection = Provider.of<ConnectionController>(context).MQTTconnection;
    if(
      connection == 'connected'
      && Provider.of<ConnectionController>(context).manager.recivedData != null
      && Provider.of<ConnectionController>(context).manager.recivedData.length >= id.toString().length
      && Provider.of<ConnectionController>(context).manager.recivedData.substring(0, id.toString().length) == id.toString()
    ){
      _lightState = Provider.of<ConnectionController>(context).manager.recivedData == "$id|1";
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: connection != 'disconnected'  ? null :[
            Desconected(),
          ],
        ),
        body: Center(
          child: CircleColorPicker(
            initialColor: atualColor,
            onChanged: (color) {
              if( (color.red - atualColor.red).abs() >= 2 || (color.green - atualColor.green).abs() >= 2 || (color.blue - atualColor.blue).abs() >= 2){
                atualColor = color;
                if(connection == 'connected'){
                  Provider.of<ConnectionController>(context, listen: false).publishMessage("$id|${color.red},${color.green},${color.blue}");
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
                _lightState = !_lightState,
                if(connection == 'connected'){
                  Provider.of<ConnectionController>(context, listen: false).publishMessage(_lightState ? "$id|1" : "$id|0"),
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