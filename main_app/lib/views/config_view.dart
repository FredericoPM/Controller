import 'package:flutter/material.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';

import 'package:main_app/widgets/desconected_widget.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/connection_controller.dart';

class Config extends StatefulWidget {
  @override
  ConfigState createState() => ConfigState();
}
class ConfigState extends State<Config> {
  TextEditingController _broker = TextEditingController();
  TextEditingController _topic = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  Widget _buildTextFild( TextEditingController controller, String labelText, String hintText){
      return TextFormField(
        enabled: true,
        controller: controller,
        validator: (s) {
          if (s.isEmpty)
            return "Preencha o campo";
          else
            return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100], width: 2),
          ),
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
              color:  Colors.grey[200],
          ),
        ),
      );
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
                            _buildTextFild(_broker, "Broker", "test.mosquitto.org"),
                            sizedBoxSpace,
                            _buildTextFild(_topic, "Topico", "SuaCasa/Quarto1"),
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