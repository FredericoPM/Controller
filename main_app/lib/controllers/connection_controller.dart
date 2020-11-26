import 'package:flutter/material.dart';
import 'package:main_app/controllers/MQTT_controller.dart';
enum MQTTConnectionState { connected, disconnected, connecting }

class ConnectionController with ChangeNotifier{
  MQTTConnectionState _appConnectionState = MQTTConnectionState.disconnected;
  String _prefix = 'Fred';
  MQTTController manager;

  String get MQTTconnection{
    return _appConnectionState.toString().substring(20);
  }
  void notfy(){
    notifyListeners();
  }
  void configureAndConnect(String broker, String topic) async{
    manager = MQTTController(
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
        notfy: notfy,
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


