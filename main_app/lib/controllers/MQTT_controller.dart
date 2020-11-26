import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
class MQTTController{

  // Private instance of client
  void Function() _disconnected;
  void Function() _connectingg;
  void Function() _connected;
  void Function() _notfy;
  MqttServerClient _client;
  final String _identifier;
  final String _host;
  final String _topic;
  String recivedData;

  // Constructor
  MQTTController({
    @required String host,
    @required String topic,
    @required String identifier,
    @required void Function() connectingg,
    @required void Function() disconnected,
    @required void Function() connected,
    @required void Function() notfy,
  }):
    _identifier = identifier,
    _host = host,
    _topic = topic,
    _connectingg = connectingg,
    _connected = connected,
    _disconnected = disconnected,
    _notfy = notfy
  ;


  void initializeMQTTClient(){
    _client = MqttServerClient(_host,_identifier);
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = onDisconnected;
    _client.secure = false;
    _client.logging(on: true);

    /// Add the successful connection callback
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;

  }
  // Connect to the host
  void connect() async{
    assert(_client != null);
    try {
      _connectingg();
      await _client.connect();
    } on Exception catch (e) {
      print('Eroor - $e');
      disconnect();
    }
  }

  void disconnect() {
    _client.disconnect();
  }

  void publish(String message){
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload);
  }

  void onSubscribed(String topic) {
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    if (_client.connectionStatus.returnCode == MqttConnectReturnCode.noneSpecified) {}
    _disconnected();
  }
  /// The successful connect callback
  void onConnected() {
    _connected();
    _client.subscribe(_topic, MqttQos.atLeastOnce);
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      recivedData = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _notfy();
    });
  }
}