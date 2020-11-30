import 'package:flutter/cupertino.dart';

class Tela {
  final int _idTela;
  final int _idAdm;
  final int _tipoTela;
  String _nomeTela;

  Tela({@required int idTela, @required int idAdm, @required int tipoTela, @required String nome}):
    this._idTela = idTela,
    this._idAdm = idAdm,
    this._tipoTela = tipoTela,
    this._nomeTela = nome
  ;

  int get idTela => _idTela;
  int get idAdm => _idAdm;
  int get tipoTela => _tipoTela;
  String get nomeTela => _nomeTela;
  set nomeTela(String nomeTela) => _nomeTela = nomeTela;

  Tela.fromJson(Map<String, dynamic> json):
    _idTela = json['idTela'],
    _idAdm = json['idAdm'],
    _tipoTela = json['tipoTela'],
    _nomeTela = json['nomeTela']
  ;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTela'] = this._idTela;
    data['idAdm'] = this._idAdm;
    data['tipoTela'] = this._tipoTela;
    data['nomeTela'] = this._nomeTela;
    return data;
  }
}