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

  bool _loaded = false;
  bool _tryedConnection = false;
  bool get loaded => this._loaded;
  bool get tryedConnection => this._tryedConnection;

  loadData() async{
    _broker = await repository.loadStringData('broker');
    _topic = await repository.loadStringData('topic');
    _loaded = true;
    notifyListeners();
  }

  startConnection() async{
    if(_broker != null && _topic != null && _appConnectionState == MQTTConnectionState.disconnected && !_tryedConnection)
      await configureAndConnect(_broker, _topic);
    _tryedConnection = true;
  }

  String get MQTTconnection{
    return _appConnectionState.toString().substring(20);
  }
  void notfy(){
    notifyListeners();
  }
  Future<void> configureAndConnect(String broker, String topic) async{
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
    await manager.connect();
    if(_appConnectionState == MQTTConnectionState.connected)
      publishMessage("DataRequest");
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


