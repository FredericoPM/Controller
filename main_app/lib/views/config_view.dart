import 'package:flutter/material.dart';
import 'package:main_app/views/sideMenu_view.dart';
class Config extends StatefulWidget {
  @override
  ConfigState createState() => ConfigState();
}
class ConfigState extends State<Config> {
  TextEditingController _broker;
  TextEditingController _topic;
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

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.wb_sunny_outlined),
              tooltip: 'Tema',
              onPressed: () => {},
            )
          ],

        ),
        body:
          Column(
            children: <Widget>[
              sizedBoxSpace,
              Center(
                child: Container(
                  width: 350,
                  child: _buildTextFild(_broker, "Broker", "test.mosquitto.org"),
                ),
              ),
              sizedBoxSpace,
              Center(
                child: Container(
                  width: 350,
                  child: _buildTextFild(_topic, "Topico", "SuaCasa/Quarto1"),
                ),
              ),
            ],
          ),
      ),
    );
  }
}