import 'package:flutter/material.dart';
import 'package:main_app/controllers/MQTT_controller.dart';

enum MQTTConnectionState { connected, disconnected, connecting }

class ConnectionController with ChangeNotifier{
  String _prefix = 'Fred';
  MQTTConnectionState _appConnectionState = MQTTConnectionState.disconnected;
  MQTTManager manager;

  String get connection{
    return _appConnectionState.toString();
  }
  void configureAndConnect(String broker, String topic) async{
    manager = MQTTManager(
        host: broker,
        topic: topic,
        identifier: _prefix,
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
  void publishMessage(String text) {
    manager.publish(text);
  }
}


