class Pagina {
  String _nome;
  String _tipo;
  bool _estadoB;
  double _estadoR;
  String _estadoRGB;

  Pagina({String nome, String tipo, bool estadoB, double estadoR, String estadoRGB}) {
    this._nome = nome;
    this._tipo = tipo;
    this._estadoB = estadoB;
    this._estadoR = estadoR;
    this._estadoRGB = estadoRGB;
  }

  String get nome => _nome;
  set nome(String nome) => _nome = nome;

  String get tipo => _tipo;
  set tipo(String tipo) => _tipo = tipo;

  bool get estadoB => _estadoB;
  set estadoB(bool estadoB) => _estadoB = estadoB;

  double get estadoR => _estadoR;
  set estadoR(double estadoR) => _estadoR = estadoR;

  String get estadoRGB => _estadoRGB;
  set estadoRGB(String estadoRGB) => _estadoRGB = estadoRGB;

  Pagina.fromJson(Map<String, dynamic> json) {
    _nome = json['nome'];
    _tipo = json['tipo'];
    _estadoB = json['estadoB'];
    _estadoR = json['estadoR'];
    _estadoRGB = json['estadoRGB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this._nome;
    data['tipo'] = this._tipo;
    data['estadoB'] = this._estadoB;
    data['estadoR'] = this._estadoR;
    data['estadoRGB'] = this._estadoRGB;
    return data;
  }
}
