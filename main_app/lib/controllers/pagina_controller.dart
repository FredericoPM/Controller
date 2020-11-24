import 'package:flutter/material.dart';
import 'package:main_app/models/pagina_model.dart';

class PaginaController  with ChangeNotifier{
  List<Pagina> paginas = [];
  PaginaController(){
    this.paginas.add(Pagina(nome: "RGB", tipo: "RGB"));
    this.paginas.add(Pagina(nome: "Normal", tipo: "Normal"));
    this.paginas.add(Pagina(nome: "Slider", tipo: "Slider"));
  }

  void add(Pagina novaPagina){
    this.paginas.add(novaPagina);
    notifyListeners();
  }
  void getAll(){
    notifyListeners();
  }
  void remove(String nomeRemovida){
    this.paginas.removeWhere((item) => item.nome == nomeRemovida);
    notifyListeners();
  }
}