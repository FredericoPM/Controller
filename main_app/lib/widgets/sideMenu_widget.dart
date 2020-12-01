import 'package:flutter/material.dart';
import 'package:main_app/views/homePage_view.dart';
import 'package:main_app/views/rgbLight_view.dart';
import 'package:main_app/views/normalLight_view.dart';
import 'package:main_app/views/sliderLight_view.dart';
import 'package:main_app/views/config_view.dart';

import 'package:main_app/controllers/pagina_controller.dart';
import 'package:main_app/widgets/novaPagina_widget.dart';
import 'package:provider/provider.dart';
import 'package:main_app/models/tela_model.dart';
class MenuDrawer extends StatefulWidget {
  @override
  MenuDrawerState createState() => MenuDrawerState();
}
class MenuDrawerState extends State<MenuDrawer>{

  PaginaController controller = PaginaController();
  void initState() {
    super.initState();
    controller.getAll();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ChangeNotifierProvider.value(
          value: controller,
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
              for(var pg in controller.telas)
                ListTile(
                  title: Text(pg.nomeTela),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if(pg.tipoTela == 1)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RGBLight(pg.nomeTela, pg.idTela)));
                    else if(pg.tipoTela == 2)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NormalLight(pg.nomeTela, pg.idTela)));
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SliderLight(pg.nomeTela, pg.idTela)));
                  },
                ),
              NovaPagina(),
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
        ),
    );
  }
}