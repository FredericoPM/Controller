import 'package:flutter/material.dart';
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
              title: Text('RGB Light'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Normal Light'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }
}