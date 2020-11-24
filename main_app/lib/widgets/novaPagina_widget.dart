import 'package:flutter/material.dart';
import 'package:main_app/widgets/textFormFild_widget.dart';
import 'package:main_app/widgets/dropDownFormFild_widget.dart';
import 'package:main_app/models/pagina_model.dart';
import 'package:provider/provider.dart';
import 'package:main_app/controllers/pagina_controller.dart';

class NovaPagina extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  String _tipoValue = "";
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
                    setSlider: () => _tipoValue = "Slider",
                    setNormal: () => _tipoValue = "Normal",
                    setRGB: () => _tipoValue = "RGB",
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
                          _tipoValue = "";
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: new Text('SALVAR', style: TextStyle(color: Colors.blue, fontSize: 14)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          controller.add(Pagina(nome: _nomeController.text, tipo: _tipoValue));
                          _nomeController.text = "";
                          _tipoValue = "";
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
  @override
  Widget build(BuildContext context) {
    PaginaController controller = Provider.of<PaginaController>(context);
    return ListTile(
      title: Text('Nova Pagina  +', style: TextStyle(color: Colors.grey),),
      onTap: () {
        _buildAddPopUp(context, controller);
      },
    );
  }
}