import 'package:flutter/material.dart';
import 'package:main_app/widgets/sideMenu_widget.dart';

import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  bool _theme = false;
  String connection;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme ?  ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
          drawer: MenuDrawer(),
          appBar: AppBar(
            title: Text("Home"),
            centerTitle: true,
          ),
        body: FooterView(
          children:<Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Bem Vindo!", style: TextStyle(fontSize: 40, color: Colors.grey[300],fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text("Não criou seu primeiro controle ainda?", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text("Ta esperando o que?", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )
          ],
          footer: new Footer(
            backgroundColor: Color(0xFF2e2e2e),
            child: Column(
              children: [
                Text("APP desenvolvidor por Frederico Prado Marques", style: TextStyle(fontSize: 11, color: Colors.grey)),
                SizedBox(height: 3),
                Text("Eng. da Computação PUC Minas", style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            )
          ),
          flex: 1, //default flex is 2
        ),
        ),
    );
  }
}