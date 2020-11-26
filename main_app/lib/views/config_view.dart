import 'package:main_app/widgets/textFormFild_widget.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';
import 'package:flutter/material.dart';

import 'package:main_app/controllers/connection_controller.dart';
import 'package:main_app/widgets/desconected_widget.dart';
import 'package:provider/provider.dart';

import 'package:main_app/repositories/config_repository.dart';
class Config extends StatefulWidget {
  @override
  ConfigState createState() => ConfigState();
}
class ConfigState extends State<Config> {
  TextEditingController _broker = TextEditingController();
  TextEditingController _topic = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ConfigRepository repository = ConfigRepository();

  loadBroker() async{
    _broker.text = await repository.loadStringData('broker');
  }
  loadTopic() async{
    _topic.text = await repository.loadStringData('topic');
  }

  @override
  void initState(){
    super.initState();
    loadBroker();
    loadTopic();
  }

  @override
  Widget build(BuildContext context) {

    ConnectionController controller = Provider.of<ConnectionController>(context);

    const sizedBoxSpace = SizedBox(height: 24);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text("Configurações"),
          centerTitle: true,
          actions: controller.connection != 'MQTTConnectionState.disconnected' ? null : [
             Desconected(),
          ],
        ),

        body:
          Center(
            child: Container(
              width: 350,
              child: Column(
                children: [
                      sizedBoxSpace,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            BuildTextFormFild(
                                controller: _broker,
                                labelText: "Broker",
                                hintText: "test.mosquitto.org"
                            ),
                            sizedBoxSpace,
                            BuildTextFormFild(
                                controller: _topic,
                                labelText: "Topico",
                                hintText: "SuaCasa/Quarto1"
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                              color: Colors.grey[700],
                              disabledColor: Colors.grey[800],
                              child: Container(
                                width: 140,
                                height: 40,
                                child: Center(
                                  child: Text("Desconectar", style: TextStyle(fontSize: 14)),
                                ),
                              ),
                              onPressed: controller.connection != 'MQTTConnectionState.disconnected' ? (){
                                controller.disconnect();
                                /*
                                repository.setStringData("broker", '');
                                repository.setStringData("topic", '');
                                 */
                              } : null,
                          ),
                          RaisedButton(
                              color: Colors.grey[700],
                              disabledColor: Colors.grey[800],
                              child: Container(
                                width: 140,
                                height: 40,
                                child: Center(
                                  child: Text("Conectar", style: TextStyle(fontSize: 14)),
                                ),
                              ),
                              onPressed: controller.connection != 'MQTTConnectionState.disconnected' ? null : (){
                                if(_formKey.currentState.validate()){
                                  controller.configureAndConnect(_broker.text, _topic.text);
                                  repository.setStringData("broker", _broker.text);
                                  repository.setStringData("topic", _topic.text);
                                }
                              },
                          ),


                        ],
                      ),
                ],
              )
            ),
          )
      ),
    );
  }
}