import 'package:flutter/cupertino.dart';

class Tela {
  final int _idTela;
  final int _tipoTela;
  String _nomeTela;

  Tela({@required int idTela, @required int tipoTela, @required String nome}):
    this._idTela = idTela,
    this._tipoTela = tipoTela,
    this._nomeTela = nome
  ;

  int get idTela => _idTela;
  int get tipoTela => _tipoTela;
  String get nomeTela => _nomeTela;
  set nomeTela(String nomeTela) => _nomeTela = nomeTela;

  Tela.fromJson(Map<String, dynamic> json):
    _idTela = json['idTela'],
    _tipoTela = json['tipoTela'],
    _nomeTela = json['nomeTela']
  ;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTela'] = this._idTela;
    data['tipoTela'] = this._tipoTela;
    data['nomeTela'] = this._nomeTela;
    return data;
  }
}