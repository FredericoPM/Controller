import 'package:flutter/material.dart';
import 'package:main_app/views/homePage_view.dart';
import 'package:main_app/views/rgbLight_view.dart';
import 'package:main_app/views/normalLight_view.dart';
import 'package:main_app/views/sliderLight_view.dart';
import 'package:main_app/views/config_view.dart';

import 'package:main_app/controllers/pagina_controller.dart';
import 'package:main_app/widgets/textFormFild_widget.dart';
import 'package:main_app/widgets/dropDownFormFild_widget.dart';
import 'package:main_app/models/tela_model.dart';

class MenuDrawer extends StatefulWidget {
  @override
  MenuDrawerState createState() => MenuDrawerState();
}
class MenuDrawerState extends State<MenuDrawer>{

  PaginaController controller = PaginaController();
  List<Tela> list = [];

  TextEditingController _nomeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _tipoValue;

  final sizedBoxSpace = SizedBox(height: 24);

  _buildAddPopUp(context, PaginaController controller) async{
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Color(0xFF2e2e2e),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildTextFormFild(
                    controller: _nomeController,
                    labelText: "Nome da pagina",
                    hintText: "Ex: Luz cozinha",
                  ),
                  sizedBoxSpace,
                  DropDownFormFild(
                    setSlider: () => _tipoValue = 3,
                    setNormal: () => _tipoValue = 2,
                    setRGB: () => _tipoValue = 1,
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                width: 500,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      child: Text("CANCELAR", style: TextStyle(color: Colors.red, fontSize: 14)),
                      onPressed: ()  {
                        _nomeController.text = "";
                        _tipoValue = 0;
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: new Text('SALVAR', style: TextStyle(color: Colors.blue, fontSize: 14)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            controller.add(
                              Tela(
                                idTela: controller.telas.length > 0 ? controller.telas.last.idTela + 1 : 1,
                                tipoTela: _tipoValue,
                                nome: _nomeController.text
                              )
                            ).then((data) => setState((){list = controller.telas;}));
                            _nomeController.text = "";
                            _tipoValue = 0;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        }
    );
  }
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAll().then((data) {
        setState(() {
          list = controller.telas;
        });
      });
    });
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
              for(var pg in list)
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
              ListTile(
                title: Text('Nova Pagina  +', style: TextStyle(color: Colors.grey),),
                onTap: () {
                  _buildAddPopUp(context, controller);
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