import 'package:flutter/material.dart';
import 'package:main_app/controllers/MQTT_controller.dart';
import 'package:main_app/repositories/connection_repository.dart';
enum MQTTConnectionState { connected, disconnected, connecting }

class ConnectionController with ChangeNotifier{
  MQTTConnectionState _appConnectionState = MQTTConnectionState.disconnected;
  ConnectionRepository repository = ConnectionRepository();
  String _prefix = 'Fred';
  MQTTController manager;
  String _broker;
  String _topic;

  _loadBroker() async{
    _broker = await repository.loadStringData('broker');
  }
  _loadTopic() async{
    _topic = await repository.loadStringData('topic');
  }

  ConnectionController(){
    _loadBroker();
    print("broker : $_broker");
    _loadTopic();
    print("topic : $_topic");
    if(_broker != null && _topic != null)
      configureAndConnect(_broker, _topic);
  }

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


