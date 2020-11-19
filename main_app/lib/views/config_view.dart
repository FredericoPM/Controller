import 'package:flutter/material.dart';
import 'file:///C:/Users/Fred/Desktop/facul/Ledstrip_controller/main_app/lib/widgets/sideMenu_widget.dart';
import 'file:///C:/Users/Fred/Desktop/facul/Ledstrip_controller/main_app/lib/widgets/desconected_widget.dart';
class Config extends StatefulWidget {
  @override
  ConfigState createState() => ConfigState();
}
class ConfigState extends State<Config> {
  TextEditingController _broker;
  TextEditingController _topic;
  bool conectado = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  Widget _buildTextFild( TextEditingController controller, String labelText, String hintText){
      return TextField(
        enabled: true,
        controller: controller,
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
    const sizedBoxSpace = SizedBox(height: 24);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text("Configurações"),
          centerTitle: true,
          actions: conectado ? null :[
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
                              onPressed: conectado ? (){
                                setState(() {
                                  conectado = !conectado;
                                });
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
                              onPressed: conectado ? null : (){
                                setState(() {
                                  conectado = !conectado;
                                });
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