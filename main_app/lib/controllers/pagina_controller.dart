import 'package:flutter/material.dart';
import 'package:main_app/models/pagina_model.dart';

class PageController{
  List<Pagina> _paginas;

  List<Pagina> get paginas{
    return _paginas;
  }
  void add(Pagina novaPagina){
    _paginas.add(novaPagina);
  }
}