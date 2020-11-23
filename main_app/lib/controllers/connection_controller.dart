import 'package:flutter/material.dart';
import 'package:main_app/controllers/MQTT_controller.dart';

enum MQTTConnectionState { connected, disconnected, connecting }

class ConnectionController with ChangeNotifier{
  MQTTConnectionState _appConnectionState = MQTTConnectionState.disconnected;
  MQTTManager manager;

  String get connection{
    return _appConnectionState.toString();
  }
  void configureAndConnect(String broker, String topic) async{
    String Prefix = 'Fred';
    manager = MQTTManager(
        host: broker,
        topic: topic,
        identifier: Prefix,
        connected: (){
          _appConnectionState = MQTTConnectionState.connected;
        },
        connectingg:(){
          _appConnectionState = MQTTConnectionState.connecting;
        },
        disconnected:(){
          _appConnectionState = MQTTConnectionState.disconnected;
        },
    );
    manager.initializeMQTTClient();
    manager.connect();
    notifyListeners();
  }
  void disconnect(){
    manager.disconnect();
    notifyListeners();
  }
  void update(){
    notifyListeners();
  }
}


