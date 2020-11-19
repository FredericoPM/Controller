import 'package:flutter/material.dart';
import 'package:main_app/views/config_view.dart';
class Desconected extends StatelessWidget {
  _displayDesconectedPopUp(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF2e2e2e),
            content: Text("Você esta desconectado!", style: TextStyle(color: Colors.grey[100])),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 500,
                child: Container(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        child: new Text('Cancelar', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: new Text('Configurações', style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Config()));
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        });
    }
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.error_outline, color: Colors.red),
        onPressed: () => _displayDesconectedPopUp(context),
    );
  }
}
