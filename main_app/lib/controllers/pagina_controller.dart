import 'package:flutter/material.dart';
import 'package:main_app/models/tela_model.dart';

class PaginaController  with ChangeNotifier{
  List<Tela> telas = [];
  PaginaController(){
    this.telas.add(Tela(idTela: 1, idAdm: 1,tipoTela: 1, nome: "RGB"));
    this.telas.add(Tela(idTela: 2, idAdm: 1,tipoTela: 2, nome: "Normal"));
    this.telas.add(Tela(idTela: 3, idAdm: 1,tipoTela: 3, nome: "Slider"));
  }

  void add(Tela novaPagina){
    this.telas.add(novaPagina);
    notifyListeners();
  }
  void getAll(){
    notifyListeners();
  }
  void remove(String nomeRemovida){
    this.telas.removeWhere((item) => item.nomeTela == nomeRemovida);
    notifyListeners();
  }
}