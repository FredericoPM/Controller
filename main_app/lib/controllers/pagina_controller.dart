import 'package:flutter/material.dart';
import 'package:main_app/models/pagina_model.dart';

class PageController  with ChangeNotifier{
  List<Pagina> paginas;


  void add(Pagina novaPagina){
    this.paginas.add(novaPagina);
    notifyListeners();
  }

  void remove(String nomeRemovida){
    this.paginas.removeWhere((item) => item.nome == nomeRemovida);
    notifyListeners();
  }
}