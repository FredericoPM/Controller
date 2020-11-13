import 'package:flutter/material.dart';
import 'package:main_app/views/homePage_view.dart';
import 'package:main_app/views/rgbLight_view.dart';
import 'package:main_app/views/normalLight_view.dart';
import 'package:main_app/views/sliderLight_view.dart';
import 'package:main_app/views/multipleLights.dart';
import 'package:main_app/views/config_view.dart';
class MenuDrawer extends StatefulWidget {
  @override
  MenuDrawerState createState() => MenuDrawerState();
}
class MenuDrawerState extends State<MenuDrawer>{
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 88,
              child : DrawerHeader(
                child: Text('Menu', style: TextStyle(fontSize: 25),),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: Text('RGB Light'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => RGBLight()));
              },
            ),
            ListTile(
              title: Text('Normal Light'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NormalLight()));
              },
            ),
            ListTile(
              title: Text('Multiple Lights'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleLights()));
              },
            ),
            ListTile(
              title: Text('Slider Light'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SliderLight()));
              },
            ),
            ListTile(
              title: Text('+ Nova Pagina', style: TextStyle(color: Colors.grey),),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Config()));
              },
            ),

          ],
        ),
    );
  }
}